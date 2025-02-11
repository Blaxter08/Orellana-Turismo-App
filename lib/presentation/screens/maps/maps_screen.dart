import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenA extends StatefulWidget {
  const MapScreenA({Key? key}) : super(key: key);

  @override
  _MapScreenAState createState() => _MapScreenAState();
}

class _MapScreenAState extends State<MapScreenA> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(-0.466667, -76.983333);
  final Set<Marker> _markers = {};
  String _categoriaSeleccionada = 'Atractivos Turísticos';
  String _searchQuery = '';

  // Mapeo de categorías a colecciones en Firestore
  final Map<String, String> _categoriasColecciones = {
    'Atractivos Turísticos': 'atractivosTuristicos',
    'Hospedaje': 'alojamientosTuristicos',
    'Alimentación': 'alimentosYBebidas',
    'Servicios': 'serviciosTuristicos',
    'Turismo Comunitario': 'turismosComunitarios',
  };

  @override
  void initState() {
    super.initState();
    _actualizarMarcadores();
  }

  Future<void> _actualizarMarcadores() async {
    setState(() {
      _markers.clear();
    });

    final String? coleccion = _categoriasColecciones[_categoriaSeleccionada];
    if (coleccion == null) return;

    final CollectionReference establecimientosRef =
    FirebaseFirestore.instance.collection(coleccion);

    try {
      QuerySnapshot querySnapshot = await establecimientosRef.get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final String nombre = data['nombre'] ?? '';
        final String logo = data['logo'] ?? '';
        final String descripcion = data['descripcion'] ?? 'Sin descripción';
        final List<dynamic> coordenadas = data['coordenadas'] ?? [0.0, 0.0];

        // Verifica que las coordenadas tengan dos elementos (latitud y longitud)
        if (coordenadas.length != 2) continue;

        final double latitud = (coordenadas[0] as num).toDouble();
        final double longitud = (coordenadas[1] as num).toDouble();

        // Aplicar filtro de búsqueda
        if (_searchQuery.isNotEmpty &&
            !nombre.toLowerCase().contains(_searchQuery.toLowerCase())) {
          continue;
        }

        final Marker marker = Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitud, longitud),
          infoWindow: InfoWindow(
            title: nombre,
            snippet: descripcion,
          ),
          onTap: () {
            _showMarkerDetails(nombre, descripcion);
          },
        );

        setState(() {
          _markers.add(marker);
        });
      }
    } catch (e) {
      print('Error al cargar marcadores: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showMarkerDetails(String nombre, String descripcion) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(descripcion),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Implementar lógica de ruta aquí
                },
                icon: Icon(Icons.directions),
                label: Text("Ver ruta"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
          _actualizarMarcadores();
        },
      ),
    );
  }

  Widget _buildCategoryButton(String categoria, IconData icon) {
    final isSelected = _categoriaSeleccionada == categoria;
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _categoriaSeleccionada = categoria;
        });
        _actualizarMarcadores();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon),
      label: Text(categoria),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa Interactivo'),
        // backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('Atractivos Turísticos', Icons.place),
                  SizedBox(width: 10,),
                  _buildCategoryButton('Hospedaje', Icons.hotel),
                  SizedBox(width: 10,),
                  _buildCategoryButton('Alimentación', Icons.restaurant),
                  SizedBox(width: 10,),
                  _buildCategoryButton('Servicios', Icons.miscellaneous_services),
                  SizedBox(width: 10,),
                  _buildCategoryButton(
                      'Turismo Comunitario', Icons.directions_boat),
                ],
              ),
            ),
          ),
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
}
