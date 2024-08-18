import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turismo_app/config/theme/app_theme.dart';
import 'package:turismo_app/infrastructure/providers/providers.dart';
import '../../../domain/entities/entities.dart';

class ComentariosWidget extends StatelessWidget {
  final String sitioId;

  const ComentariosWidget({Key? key, required this.sitioId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comentariosService = ComentarioService();

    return StreamBuilder<List<Comentario>>(
      stream: comentariosService.getComentariosPorSitio(sitioId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final comentarios = snapshot.data ?? [];
        if ( comentarios.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Image.asset(
                  height: 50,
                  width: 50,
                  'assets/extraviado.png'),
              Text('Aun no hay comentarios!!', style: GoogleFonts.roboto(
                fontSize:16,
              ),),Text('Quieres ser el primero en comentar?', style: GoogleFonts.roboto(
                fontSize:16,
                fontWeight: FontWeight.bold,
                color:Colors.green
              ),),
              Expanded(
                child: ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    final comentario = comentarios[index];
                    return _buildComentarioItem(comentario);
                  },
                ),
              ),
              AgregarComentarioWidget(sitioId: sitioId),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comentarios.length,
                itemBuilder: (context, index) {
                  final comentario = comentarios[index];
                  return _buildComentarioItem(comentario);
                },
              ),
            ),
            AgregarComentarioWidget(sitioId: sitioId),
            SizedBox(height: 5,)
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
                  color: Colors.grey[300], // Fondo gris del círculo
                  shape: BoxShape.circle, // Forma de círculo
                ),
                width: 50, // Ancho del círculo
                height: 50, // Altura del círculo
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Fondo gris del contenedor
                    borderRadius: BorderRadius.circular(20), // Bordes redondeados de 20px
                  ),
                ),
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final userData = snapshot.data?.data() as Map<String, dynamic>?; // Indica el tipo de dato esperado

        if (userData == null) {
          return Text('Usuario no encontrado');
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userData['photoUrl'] as String), // Asegúrate de que 'foto' es de tipo String
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(10), // Añadimos un espacio alrededor del contenido
                decoration: BoxDecoration(
                  // color: ThemeData.light().primaryColorLight, // Fondo gris
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados de 20px
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData['displayName'] as String, // Asegúrate de que 'nombre' es de tipo String
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(comentario.comentario),
                  ],
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
  final String sitioId;

  const AgregarComentarioWidget({Key? key, required this.sitioId}) : super(key: key);

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
        'idSitio': widget.sitioId,
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
