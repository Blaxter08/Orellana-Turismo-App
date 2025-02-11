import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/turismo comunitario/turismo_comunitario_entidad.dart';


class TurismoComunitarioDetailScreen extends StatelessWidget {
  final TurismoComunitario turismoComunitario;

  TurismoComunitarioDetailScreen({required this.turismoComunitario});

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
                  turismoComunitario.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 6.0, color: Colors.black)],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: turismoComunitario.logo,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildOverviewSection(),
              _buildContactSection(),
              _buildSocialMediaSection(),
              _buildGallerySection(context),
              _buildMapSection(),
              _buildRoutesSection(),
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
              // Tipo de servicio
              Text('Tipo de Servicio:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(turismoComunitario.tipoServicio, textAlign: TextAlign.justify),
              SizedBox(height: 10),

              // Dirección
              Text('Dirección:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(turismoComunitario.direccion, textAlign: TextAlign.justify),
              SizedBox(height: 10),

              // Horario
              Text('Horario:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(turismoComunitario.horario, textAlign: TextAlign.justify),
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

              // Teléfonos
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Teléfonos:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              ...turismoComunitario.telefonos.map((telefono) => GestureDetector(
                onTap: () => _launchUrl('tel:$telefono'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
                  child: Text(
                    telefono,
                    style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                  ),
                ),
              )),

              SizedBox(height: 10),

              // Correo
              Row(
                children: [
                  Icon(Icons.email, color: Colors.teal),
                  SizedBox(width: 8),
                  Text('Correo:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _launchUrl('mailto:${turismoComunitario.correo}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 10.0),
                  child: Text(
                    turismoComunitario.correo,
                    style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                  ),
                ),
              ),

              // Sitio Web
              if (turismoComunitario.sitioWeb.isNotEmpty)
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
                      onTap: () => _launchUrl(turismoComunitario.sitioWeb.contains('http')
                          ? turismoComunitario.sitioWeb
                          : 'https://${turismoComunitario.sitioWeb}'),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 5.0),
                        child: Text(
                          turismoComunitario.sitioWeb,
                          style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
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

  Widget _buildSocialMediaSection() {
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
              SizedBox(height: 10),
              ...turismoComunitario.redesSociales.entries.map((entry) {
                return Row(
                  children: [
                    Icon(Icons.link, color: Colors.teal),
                    SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => _launchUrl(entry.value),
                      child: Text(
                        entry.value,
                        style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                );
              }),
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
          Text('Galería de Imágenes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: turismoComunitario.imagenes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: turismoComunitario.imagenes[index],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                    target: LatLng(turismoComunitario.coordenadas[0], turismoComunitario.coordenadas[1]),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('location'),
                      position: LatLng(turismoComunitario.coordenadas[0], turismoComunitario.coordenadas[1]),
                      infoWindow: InfoWindow(title: turismoComunitario.nombre),
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

  Widget _buildRoutesSection() {
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
              Text('Rutas Disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ...turismoComunitario.rutasDisponibles.map((ruta) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text('- $ruta'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
