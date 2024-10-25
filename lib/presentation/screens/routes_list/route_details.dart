import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutaDetalleScreen extends StatefulWidget {
  final String rutaId;

  const RutaDetalleScreen({Key? key, required this.rutaId}) : super(key: key);

  @override
  _RutaDetalleScreenState createState() => _RutaDetalleScreenState();
}

class _RutaDetalleScreenState extends State<RutaDetalleScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  List<bool>? _puntosDeInteresVisitados;

  @override
  void initState() {
    super.initState();
    _loadUserVisitedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Ruta'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('rutas').doc(widget.rutaId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var rutaData = snapshot.data?.data() as Map<String, dynamic>?;

          if (rutaData == null || rutaData['puntosDeInteres'] == null || rutaData['puntosDeInteres'].isEmpty) {
            return Center(child: Text('No se encontraron datos para esta ruta.'));
          }

          _markers = _createMarkers(rutaData['puntosDeInteres']);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                child: GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      rutaData['puntosDeInteres'][0]['latitud'] ?? 0.0,
                      rutaData['puntosDeInteres'][0]['longitud'] ?? 0.0,
                    ),
                    zoom: 12,
                  ),
                  markers: _markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  rutaData['nombre'] ?? 'Sin nombre',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rutaData['descripcion'] ?? 'Sin descripción'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: rutaData['puntosDeInteres']?.length ?? 0,
                  itemBuilder: (context, index) {
                    var punto = rutaData['puntosDeInteres'][index];
                    bool visitado = _puntosDeInteresVisitados?[index] ?? false;

                    return ListTile(
                      leading: visitado
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.circle, color: Colors.grey),
                      title: Text(punto['nombre'] ?? 'Punto sin nombre'),
                      subtitle: Text(punto['descripcion'] ?? 'Sin descripción'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _markAsVisited(index);
                        },
                        child: Text(visitado ? 'Visitado' : 'Marcar como Visitado'),
                      ),
                      onTap: () {
                        if (punto['latitud'] != null && punto['longitud'] != null) {
                          _mapController?.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(punto['latitud'], punto['longitud']),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Coordenadas no disponibles para este punto.')),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _createMarkers(List<dynamic> puntosDeInteres) {
    return puntosDeInteres.where((punto) {
      return punto['latitud'] != null && punto['longitud'] != null;
    }).map((punto) {
      return Marker(
        markerId: MarkerId(punto['nombre'] ?? 'Sin nombre'),
        position: LatLng(
          punto['latitud'] ?? 0.0,
          punto['longitud'] ?? 0.0,
        ),
        infoWindow: InfoWindow(
          title: punto['nombre'] ?? 'Sin nombre',
          snippet: punto['descripcion'] ?? 'Sin descripción',
        ),
      );
    }).toSet();
  }

  void _loadUserVisitedData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    var userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    var userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      var rutasVisitadas = userSnapshot.data()?['rutas_visitadas'] ?? {};
      setState(() {
        _puntosDeInteresVisitados = List<bool>.from(
            rutasVisitadas[widget.rutaId]?['puntosDeInteresVisitados'] ?? []);
      });
    }

    if (_puntosDeInteresVisitados == null || _puntosDeInteresVisitados!.isEmpty) {
      var rutaSnapshot = await FirebaseFirestore.instance.collection('rutas').doc(widget.rutaId).get();
      if (rutaSnapshot.exists) {
        setState(() {
          _puntosDeInteresVisitados = List<bool>.filled(rutaSnapshot['puntosDeInteres'].length, false);
        });
      }
    }
  }

  void _markAsVisited(int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _puntosDeInteresVisitados?[index] = true;
    });

    var userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    var userSnapshot = await userDocRef.get();

    var rutasVisitadas = userSnapshot.data()?['rutas_visitadas'] ?? {};

    rutasVisitadas[widget.rutaId] = {
      'puntosDeInteresVisitados': _puntosDeInteresVisitados,
    };

    await userDocRef.update({'rutas_visitadas': rutasVisitadas});
  }
}
