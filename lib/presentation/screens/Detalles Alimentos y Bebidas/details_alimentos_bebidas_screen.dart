import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_app/domain/entities/alimentos%20y%20bebidas/alimentos_bebidas_entidad.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../domain/entities/servicios turisiticos/servicios_turisticos_entidad.dart';
import '../../widgets/shared/comentarios_Widget.dart';
import '../Detalles atractivo/details_atractivos_screen.dart';

class AlimentosBebidasDetailScreen extends StatelessWidget {
  final AlimentosYBebidas alimentosYBebidas;

  AlimentosBebidasDetailScreen({required this.alimentosYBebidas});

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
                alimentosYBebidas.nombre,
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
                    imageUrl: alimentosYBebidas.logo,
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
                _buildOverviewSection(),
                _buildContactSection(),
                _buildSocialMediaSection(context),
                _buildGallerySection(),
                _buildMapSection(),
                _buildCommentsSection(),
              ],
            ),
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
                  Text(alimentosYBebidas.direccion, textAlign: TextAlign.justify),
                ],
              ),
              SizedBox(height: 10),

              // Categoría
              Text('Categoría:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('${alimentosYBebidas.categoriaPrincipal} - ${alimentosYBebidas.subCategoria}'),
              SizedBox(height: 10),
              // Horarios
              Text('Horario:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Abre: ${alimentosYBebidas.horaApertura}, Cierra: ${alimentosYBebidas.horaCierre}',
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
              ...alimentosYBebidas.telefonosMoviles.map((telefono) => GestureDetector(
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
              // Row(
              //   children: [
              //     Icon(Icons.phone, color: Colors.teal),
              //     SizedBox(width: 8),
              //     Text('Teléfonos Convencionales:', style: TextStyle(fontWeight: FontWeight.bold)),
              //   ],
              // ),
              // SizedBox(height: 5),
              // ...alimentosYBebidas.t.map((telefono) => GestureDetector(
              //   onTap: () => _launchUrl('tel:${telefono.replaceAll(RegExp(r'\s+'), '')}'),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
              //     child: Text(
              //       telefono,
              //       style: TextStyle(color: Colors.blueAccent,),
              //     ),
              //   ),
              // )),

              SizedBox(height: 10),

              // Correos
              if (alimentosYBebidas.correo.isNotEmpty)
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.teal),
                    SizedBox(width: 8),
                    Text('Correo(s):', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _launchUrl('mailto:${alimentosYBebidas.correo}'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 10.0),
                  child: Text(
                    alimentosYBebidas.correo,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
              // Sitio Web
              if (alimentosYBebidas.sitioWeb.isNotEmpty)
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
                      onTap: () => _launchUrl(alimentosYBebidas.sitioWeb.contains('http') ? alimentosYBebidas.sitioWeb : 'https://${alimentosYBebidas.sitioWeb}'),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 5.0),
                        child: Text(
                          alimentosYBebidas.sitioWeb,
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
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
              ...alimentosYBebidas.redesSociales.entries.map((entry) => GestureDetector(
                onTap: () => _launchURL(context, entry.value), // Aquí se pasa `context` como primer argumento
                child: Row(
                  children: [
                    Icon(_getSocialMediaIcon(entry.key), color: Colors.blue),
                    SizedBox(width: 8),
                    Text('${entry.key}', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGallerySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Galería de Imágenes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: alimentosYBebidas.imagenes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                          imageUrl: alimentosYBebidas.imagenes[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: alimentosYBebidas.imagenes[index],
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
                    target: LatLng(
                      alimentosYBebidas.coordenadas[0],
                      alimentosYBebidas.coordenadas[1],
                    ),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('servicioLocation'),
                      position: LatLng(
                        alimentosYBebidas.coordenadas[0],
                        alimentosYBebidas.coordenadas[1],
                      ),
                      infoWindow: InfoWindow(title: alimentosYBebidas.nombre),
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
          SizedBox(height: 300, child: ComentariosWidget(establishmentId: alimentosYBebidas.id.toString())),
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

  void _launchURL(BuildContext context, String url) async {
    // Detecta si es un número de teléfono, correo o URL web y ajusta el prefijo
    if (url.startsWith('tel:') || url.startsWith('mailto:') || url.startsWith('http')) {
      // Si el prefijo es correcto, continúa
    } else if (url.contains('@')) {
      url = 'mailto:$url';
    } else if (RegExp(r'^\d+$').hasMatch(url.replaceAll(RegExp(r'\s+'), ''))) {
      url = 'tel:$url';
    } else {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);

    // Usa `canLaunchUrl` y `launchUrl` en lugar de `canLaunch` y `launch`
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace: $url')),
      );
    }
  }





  IconData _getSocialMediaIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      default:
        return FontAwesomeIcons.globe;
    }
  }
}
