import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turismo_app/presentation/screens/routes_list/route_details.dart';

class RutasTuristicasScreen extends StatelessWidget {
  static const name = 'rutas-turisticas-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutas Turísticas'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('rutas').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              // Obtener la duración de la ruta como un string desde Firestore
              final String duracion = document['duracion'];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      document['imagen'],
                      width: 100,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    document['nombre'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(document['descripcion']),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Duración: $duracion',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navegar a la pantalla de detalles de la ruta
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RutaDetalleScreen(
                          rutaId: document.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
