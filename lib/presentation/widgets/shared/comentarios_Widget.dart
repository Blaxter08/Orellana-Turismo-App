import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/entities.dart';
import '../../../infrastructure/providers/providers.dart';

class ComentariosWidget extends StatelessWidget {
  final String establishmentId;

  const ComentariosWidget({Key? key, required this.establishmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comentariosService = ComentarioService();

    return StreamBuilder<List<Comentario>>(
      stream: comentariosService.getComentariosPorEstablishment(establishmentId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final comentarios = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (comentarios.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    Image.asset('assets/extraviado.png', height: 50, width: 50),
                    Text(
                      'Aún no hay comentarios!!',
                      style: GoogleFonts.roboto(fontSize: 16),
                    ),
                    Text(
                      '¿Quieres ser el primero en comentar?',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            if (comentarios.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    final comentario = comentarios[index];
                    return _buildComentarioItem(comentario);
                  },
                ),
              ),
            AgregarComentarioWidget(establishmentId: establishmentId),
          ],
        );
      },
    );
  }

  Widget _buildComentarioItem(Comentario comentario) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(comentario.idUsuario).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final userData = snapshot.data?.data() as Map<String, dynamic>?;

        if (userData == null) {
          return Text('Usuario no encontrado');
        }

        // Protección adicional para los valores nulos
        final photoUrl = userData['photoUrl'] as String? ?? 'https://example.com/default_image.png';
        final displayName = userData['displayName'] as String? ?? 'Usuario Anónimo';
        final comentarioTexto = comentario.comentario ?? 'Sin comentarios';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(comentarioTexto),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AgregarComentarioWidget extends StatefulWidget {
  final String establishmentId;

  const AgregarComentarioWidget({Key? key, required this.establishmentId}) : super(key: key);

  @override
  _AgregarComentarioWidgetState createState() => _AgregarComentarioWidgetState();
}

class _AgregarComentarioWidgetState extends State<AgregarComentarioWidget> {
  final TextEditingController _comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          TextField(
            controller: _comentarioController,
            decoration: InputDecoration(
              hintText: 'Escribe tu comentario aquí',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  agregarComentario();
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void agregarComentario() {
    String comentarioTexto = _comentarioController.text.trim();

    if (comentarioTexto.isNotEmpty) {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> comentarioData = {
        'comentario': comentarioTexto,
        'fecha': FieldValue.serverTimestamp(),
        'idUsuario': userId,
        'idEstablecimiento': widget.establishmentId,
      };

      FirebaseFirestore.instance.collection('comentarios').add(comentarioData);

      _comentarioController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, escribe tu comentario antes de agregarlo.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }
}
