import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/atractivos turisticos/atractivos_turisticos_entidad.dart';

class AtractivoDetailScreen extends StatelessWidget {
  final AtractivoTuristico atractivo;

  AtractivoDetailScreen({required this.atractivo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                width: double.infinity,
                child: Text(
                  atractivo.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 6.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: atractivo.logo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildDetailsSection(context),
                _buildActivitiesIcons(atractivo.actividades),
                _buildGallerySection(),
                _buildMapSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                atractivo.direccion,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              Text(
                'Descripción:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Text(atractivo.descripcion),
              SizedBox(height: 15),
              Text(
                'Qué hacer:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Text(atractivo.quehacer),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitiesIcons(List<String> actividades) {
    // Mapeo de nombres de actividades a íconos de FontAwesome
    final Map<String, IconData> activityIcons = {
      'Senderismo': FontAwesomeIcons.personHiking,
      'Natación': FontAwesomeIcons.swimmer,
      'Paseo en bote': FontAwesomeIcons.bolt,
      'Fotografía': FontAwesomeIcons.camera,
      'Hoteles': FontAwesomeIcons.hotel,
      'Restaurantes': FontAwesomeIcons.utensils,
      'Agencia de viajes': FontAwesomeIcons.bagShopping,
      'Información turística': FontAwesomeIcons.info,
      'Ciclismo': FontAwesomeIcons.biking,
      'Camping': FontAwesomeIcons.campground,
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actividades",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: actividades.map((actividad) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.teal[100],
                        child: Icon(
                          activityIcons[actividad] ?? FontAwesomeIcons.question,
                          size: 24,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 60,
                        child: Text(
                          actividad,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Galería de Imágenes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: atractivo.imagenes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: atractivo.imagenes[index],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.broken_image),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ubicación:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      atractivo.coordenadas[0],
                      atractivo.coordenadas[1],
                    ),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('attractionLocation'),
                      position: LatLng(
                        atractivo.coordenadas[0],
                        atractivo.coordenadas[1],
                      ),
                      infoWindow: InfoWindow(title: atractivo.nombre),
                    ),
                  },
                ),
              ),
              SizedBox(height: 10),
              Text('Cómo llegar: ${atractivo.comoLlegar}'),
            ],
          ),
        ),
      ),
    );
  }
}
