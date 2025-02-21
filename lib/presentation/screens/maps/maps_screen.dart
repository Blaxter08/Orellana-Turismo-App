import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../infrastructure/providers/map/map_provider.dart';
import '../../../infrastructure/services/localizacion/location_service.dart';

class MapScreenA extends ConsumerStatefulWidget {
  const MapScreenA({Key? key}) : super(key: key);

  @override
  _MapScreenAState createState() => _MapScreenAState();
}

class _MapScreenAState extends ConsumerState<MapScreenA> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition; // Será nulo hasta obtener la ubicación real
  bool _isLoadingLocation = true;

  String? _selectedName;
  String? _selectedDescription;
  String? _selectedAddress;
  double? _selectedRating;
  String? _selectedImage;
  LatLng? _selectedPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  /// Obtiene la ubicación del usuario y actualiza `_currentPosition`
  Future<void> _getUserLocation() async {
    final locationService = LocationService();
    try {
      final posicion = await locationService.getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(posicion.latitude, posicion.longitude);
        _isLoadingLocation = false;
      });
      print("📍 Ubicación actual del usuario: $_currentPosition");
    } catch (e) {
      print("❌ Error obteniendo la ubicación: $e");
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  /// Mueve la cámara a la ubicación actual del usuario
  void _moveToUserLocation() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        _currentPosition!,
        14.0,
      ));
    }
  }

  /// Función que se ejecuta al crear el mapa
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _moveToUserLocation();
  }

  /// Muestra el panel emergente con información del marcador
  void _showMarkerDetails() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedName ?? "Lugar sin nombre",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (_selectedImage != null && _selectedImage!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _selectedImage!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 8),
              Text(_selectedDescription ?? "Sin descripción disponible."),
              const SizedBox(height: 6),
              Text("📍 Dirección: ${_selectedAddress ?? 'No especificada'}"),
              if (_selectedRating != null)
                Text("⭐ Puntuación: ${_selectedRating!.toStringAsFixed(1)}"),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selectedPosition != null ? _openGoogleMaps : null,
                icon: const Icon(Icons.directions),
                label: const Text("Cómo llegar"),
                // style: ElevatedButton.styleFrom(backgroundColor: Colors.white10),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Abre Google Maps con la ruta al marcador seleccionado
  void _openGoogleMaps() async {
    if (_selectedPosition == null) return;

    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=${_selectedPosition!.latitude},${_selectedPosition!.longitude}";
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print("❌ No se pudo abrir Google Maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mientras _currentPosition sea nulo, se muestra el indicador de carga.
    if (_currentPosition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final marcadoresAsync = ref.watch(marcadoresProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Interactivo'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 14.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: marcadoresAsync.when(
              data: (marcadores) {
                return Set<Marker>.from(marcadores.map((marker) {
                  return marker.copyWith(
                    onTapParam: () {
                      setState(() {
                        _selectedName = marker.infoWindow.title;
                        _selectedDescription = marker.infoWindow.snippet;
                        _selectedPosition = marker.position;
                      });
                      _showMarkerDetails();
                    },
                  );
                }));
              },
              loading: () {
                return {};
              },
              error: (err, stack) {
                print("❌ Error al cargar marcadores: $err");
                return {};
              },
            ),
          ),
          _buildCategorySelector(ref),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToUserLocation,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  /// Construye los botones de selección de categorías con mejor diseño y animaciones
  Widget _buildCategorySelector(WidgetRef ref) {
    final categorias = [
      {"nombre": "Atractivos Turísticos", "icon": FontAwesomeIcons.mapMarkedAlt, "color": Colors.green},
      {"nombre": "Hospedaje", "icon": FontAwesomeIcons.hotel, "color": Colors.blue},
      {"nombre": "Alimentación", "icon": FontAwesomeIcons.utensils, "color": Colors.orange},
      {"nombre": "Servicios", "icon": FontAwesomeIcons.cogs, "color": Colors.purple},
      {"nombre": "Turismo Comunitario", "icon": FontAwesomeIcons.solidHandshake, "color": Colors.teal},
    ];

    final selectedCategory = ref.watch(categoriaProvider);

    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categorias.map((categoria) {
            final isSelected = selectedCategory == (categoria["nombre"] as String);
            final Color categoriaColor = categoria["color"] as Color;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? categoriaColor : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    ref.read(categoriaProvider.notifier).state = categoria["nombre"] as String;
                    print("🔄 Cambiando categoría a: ${categoria["nombre"]}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          categoria["icon"] as IconData,
                          color: isSelected ? Colors.white : categoriaColor,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          categoria["nombre"] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : categoriaColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
