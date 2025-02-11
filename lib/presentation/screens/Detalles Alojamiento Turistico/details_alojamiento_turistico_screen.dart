import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/alojamientos turisticos/alojamientos_turisiticos_entidad.dart';
import '../../widgets/shared/comentarios_Widget.dart';
import '../Detalles atractivo/details_atractivos_screen.dart';

class AlojamientoDetailScreen extends StatelessWidget {
  final AlojamientoTuristico alojamiento;

  AlojamientoDetailScreen({required this.alojamiento});

  bool _isOpenNow() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    try {
      final openTime = formatter.parse(alojamiento.horaApertura);
      final closeTime = formatter.parse(alojamiento.horaCierre);
      return now.isAfter(openTime) && now.isBefore(closeTime);
    } catch (e) {
      return false;
    }
  }

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
                  alojamiento.nombre,
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
                  // Imagen de fondo
                  CachedNetworkImage(
                    imageUrl: alojamiento.logo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // Degradado oscuro
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
              // Dirección
              Text('Dirección:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.red.shade300,),
                  SizedBox(width: 10,),
                  Flexible(child: Text(alojamiento.direccion, textAlign: TextAlign.justify)),
                ],
              ),
              SizedBox(height: 10),

              // Categoría
              Text('Categoría:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('${alojamiento.categoriaPrincipal} - ${alojamiento.subCategoria}'),
              SizedBox(height: 10),

              // Puntuación como estrellas
              Row(
                children: [
                  _buildRatingStars(alojamiento.puntuacion),
                ],
              ),
              SizedBox(height: 10),

              // Horarios
              Text('Horario:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Abre: ${alojamiento.horaApertura}, Cierra: ${alojamiento.horaCierre}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Método para construir las estrellas de puntuación
  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) > 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
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

              // Teléfonos Móviles
              Row(
                children: [
                  Icon(Icons.phone_android, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Teléfonos Móviles:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              ...alojamiento.telefonosMoviles.map((telefono) => GestureDetector(
                onTap: () => _launchUrl('tel:${telefono.replaceAll(RegExp(r'\s+'), '')}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
                  child: Text(
                    telefono,
                    style: TextStyle(color: Colors.blueAccent, ),
                  ),
                ),
              )),

              SizedBox(height: 10),

              // Teléfonos Convencionales
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Teléfonos Convencionales:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              ...alojamiento.telefonosConvencionales.map((telefono) => GestureDetector(
                onTap: () => _launchUrl('tel:${telefono.replaceAll(RegExp(r'\s+'), '')}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
                  child: Text(
                    telefono,
                    style: TextStyle(color: Colors.blueAccent,),
                  ),
                ),
              )),

              SizedBox(height: 10),

              // Correos
              Row(
                children: [
                  Icon(Icons.email, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Correo(s):', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              ...alojamiento.correos.map((correo) => GestureDetector(
                onTap: () => _launchUrl('mailto:$correo'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 10.0),
                  child: Text(
                    correo,
                    style: TextStyle(color: Colors.blueAccent,),
                  ),
                ),
              )),

              // Sitio Web
              if (alojamiento.sitioWeb.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.web, color: Colors.teal),
                        SizedBox(width: 8),
                        Text('Sitio Web:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _launchUrl(alojamiento.sitioWeb.contains('http') ? alojamiento.sitioWeb : 'https://${alojamiento.sitioWeb}'),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 5.0),
                        child: Text(
                          alojamiento.sitioWeb,
                          style: TextStyle(color: Colors.blueAccent, ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
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
              itemCount: alojamiento.imagenes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                          imageUrl: alojamiento.imagenes[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: alojamiento.imagenes[index],
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
// Método para obtener el ícono de la red social según su nombre
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

// Método para abrir la URL
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
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
                    target: LatLng(alojamiento.coordenadas[0], alojamiento.coordenadas[1]),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('alojamientoLocation'),
                      position: LatLng(alojamiento.coordenadas[0], alojamiento.coordenadas[1]),
                      infoWindow: InfoWindow(title: alojamiento.nombre),
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
          Text(
            'Comentarios',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
              height:  300,
              child: ComentariosWidget(establishmentId: alojamiento.id.toString() )),  // Llama al widget personalizado para mostrar los comentarios
        ],
      ),
    );
  }
}