import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/servicios turisiticos/servicios_turisticos_entidad.dart';
import '../../widgets/shared/comentarios_Widget.dart';
import '../Detalles atractivo/details_atractivos_screen.dart';

class ServicioTuristicoDetailScreen extends StatelessWidget {
  final ServicioTuristico servicio;

  ServicioTuristicoDetailScreen({required this.servicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Colors.teal,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 72.0, vertical: 8.0),
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  servicio.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(offset: Offset(0.0, 0.0), blurRadius: 6.0, color: Colors.black),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: servicio.logo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildOverviewSection(),
              _buildContactSection(),
              _buildSocialMediaSection(context),
              _buildGallerySection(context),
              _buildMapSection(),
              _buildCommentsSection(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
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
              Text('Dirección:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.red.shade300,),
                  SizedBox(width: 10,),
                  Flexible(child: Text(servicio.direccion, textAlign: TextAlign.justify, )),
                ],
              ),
              SizedBox(height: 10),

              Text('Categoría:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('${servicio.categoriaPrincipal} - ${servicio.subCategoria}'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
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
              Text('Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Row(
                children: [
                  Icon(Icons.phone_android, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Teléfonos Móviles:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              ...servicio.telefonosMoviles.map((telefono) => GestureDetector(
                onTap: () => _launchUrl('tel:${telefono.replaceAll(RegExp(r'\s+'), '')}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
                  child: Text(
                    telefono,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              )),
              SizedBox(height: 10),

              if (servicio.correo.isNotEmpty)
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.teal),
                    SizedBox(width: 8),
                    Text('Correo(s):', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _launchUrl('mailto:${servicio.correo}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 10.0),
                  child: Text(
                    servicio.correo,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection(BuildContext context) {
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
              Text('Redes Sociales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ...servicio.redesSociales.entries.map((entry) => GestureDetector(
                onTap: () => _launchUrl(entry.value), // Método para abrir la URL
                child: Row(
                  children: [
                    Icon(_getSocialMediaIcon(entry.key), color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  IconData _getSocialMediaIcon(String socialMedia) {
    switch (socialMedia.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'twitter':
        return Icons.alternate_email;
      default:
        return Icons.link; // Ícono predeterminado
    }
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
              itemCount: servicio.imagenes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                          imageUrl: servicio.imagenes[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: servicio.imagenes[index],
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
              Text('Ubicación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(servicio.coordenadas[0], servicio.coordenadas[1]),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('serviceLocation'),
                      position: LatLng(servicio.coordenadas[0], servicio.coordenadas[1]),
                      infoWindow: InfoWindow(title: servicio.nombre),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Comentarios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(height: 300, child: ComentariosWidget(establishmentId: servicio.id)),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
}
