import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenA extends StatefulWidget {
  const MapScreenA({Key? key}) : super(key: key);

  @override
  _MapScreenAState createState() => _MapScreenAState();
}

class _MapScreenAState extends State<MapScreenA> {
  // Controlador del Google Map
  late GoogleMapController mapController;

  // Posición inicial del mapa (ejemplo en Orellana, Ecuador)
  final LatLng _initialPosition = const LatLng(-0.466667, -76.983333);

  // Lista de marcadores para los establecimientos
  final Set<Marker> _markers = {};

  // Categoría seleccionada
  String _categoriaSeleccionada = 'Hospedaje';

  // Colección de Firestore para los establecimientos
  final CollectionReference _establecimientosRef = FirebaseFirestore.instance.collection('establecimientos');

  @override
  void initState() {
    super.initState();
    // Cargar los establecimientos de la categoría por defecto
    _actualizarMarcadores('Hospedaje');
  }

  // Método para obtener los establecimientos desde Firestore y actualizar los marcadores
  Future<void> _actualizarMarcadores(String categoria) async {
    // Limpiar los marcadores anteriores
    setState(() {
      _markers.clear();
    });

    // Consultar establecimientos por categoría en Firestore
    QuerySnapshot querySnapshot = await _establecimientosRef
        .where('categoria', isEqualTo: categoria)
        .get();

    // Crear marcadores para cada establecimiento
    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final double latitud = data['latitud']; // Campo latitud
      final double longitud = data['longitud']; // Campo longitud
      final String nombre = data['nombre'];

      final Marker marker = Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(latitud, longitud),
        infoWindow: InfoWindow(
          title: nombre,
          snippet: '$categoria',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  // Método para cuando el mapa se carga
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa Interactivo'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Fila de botones de categorías
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Hospedaje'),
                _buildCategoryButton('Alimentación'),
                _buildCategoryButton('Transporte'),
              ],
            ),
          ),
          // Mapa de Google
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir los botones de categoría
  Widget _buildCategoryButton(String categoria) {
    final isSelected = _categoriaSeleccionada == categoria;
    return ElevatedButton(
      onPressed: () {
        // Cambiar la categoría seleccionada y actualizar los marcadores
        setState(() {
          _categoriaSeleccionada = categoria;
          _actualizarMarcadores(categoria);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(categoria),
    );
  }
}
