import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_app/infrastructure/providers/atractivos_turisticos/atractivos_turisticos_provider.dart';
import 'package:turismo_app/presentation/widgets/shared/comentarios_Widget.dart';
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
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
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: atractivo.logo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildShimmerPlaceholder(),
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
                _buildOverviewSection(context),
                _buildActivitiesSection(),
                _buildGallerySection(context),
                _buildMapSection(),
                _buildCommentsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
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
                'Dirección',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.red.shade300,),
                  SizedBox(width: 10,),
                  Flexible(
                    child: Text(
                      atractivo.direccion,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Descripción',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(atractivo.descripcion, textAlign: TextAlign.justify,),
              SizedBox(height: 15),
              Text(
                'Qué hacer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(atractivo.quehacer),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitiesSection() {
    final Map<String, IconData> activityIcons = {
      'Senderismo': FontAwesomeIcons.personHiking,
      'Natación': FontAwesomeIcons.swimmer,
      'Paseo en bote': FontAwesomeIcons.ship,
      'Fotografía': FontAwesomeIcons.camera,
      'Fotografia': FontAwesomeIcons.camera,
      'Hoteles': FontAwesomeIcons.hotel,
      'Restaurante': FontAwesomeIcons.utensils,
      'Agencia de viajes': FontAwesomeIcons.mapSigns,
      'Información turística': FontAwesomeIcons.infoCircle,
      'Ciclismo': FontAwesomeIcons.biking,
      'Camping': FontAwesomeIcons.campground,
      'Pesca': FontAwesomeIcons.fish,
      'Mirador': FontAwesomeIcons.binoculars,
      'Informacion turistica': FontAwesomeIcons.info,
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
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: atractivo.actividades.map((actividad) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.teal[100],
                        child: Icon(
                          activityIcons[actividad] ?? FontAwesomeIcons.question,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: 60,
                        child: Text(
                          actividad,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
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

  Widget _buildGallerySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Galería de Imágenes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: atractivo.imagenes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                          imageUrl: atractivo.imagenes[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: atractivo.imagenes[index],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => _buildShimmerPlaceholder(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comentarios',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
              height:  300,
              child: ComentariosWidget(establishmentId: atractivo.documentSnapshot!.id )),  // Llama al widget personalizado para mostrar los comentarios
        ],
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(child: Icon(Icons.image, color: Colors.grey[400], size: 50)),
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
                'Ubicación',
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

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  ImagePreviewScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => _buildShimmerPlaceholder(),
          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(child: Icon(Icons.image, color: Colors.grey[400], size: 50)),
    );
  }
}
