import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../widgets/shared/comentarios_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../widgets/shared/comentarios_widget.dart';

class EstablishmentDetailsScreen extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentDetailsScreen({
    Key? key,
    required this.establishment,
    required String establishmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(establishment.nombre),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, establishment),
            SizedBox(height: 16.0),
            Divider(),
            _buildMapSection(context, establishment),
            SizedBox(height: 16.0),
            _buildContactInfo(establishment),
            Divider(thickness: 2),
            _buildOpeningHours(establishment.horaApertura, establishment.horaCierre),
            SizedBox(height: 16.0),
            _buildSectionTitle('Servicios'),
            _buildServices(establishment.servicios),
            SizedBox(height: 16.0),
            _buildSectionTitle('Productos'),
            _buildProducts(establishment.productos),
            SizedBox(height: 16.0),
            _buildSectionTitle('Imágenes'),
            _buildImages(context, establishment.imagenes),
            SizedBox(height: 16.0),
            _buildSectionTitle('Comentarios'),
            Container(
              height: 300,
              child: ComentariosWidget(establishmentId: establishment.id),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // Método para convertir las coordenadas del establecimiento a LatLng
  LatLng _convertToLatLng(Coordenadas coordenadas) {
    return LatLng(coordenadas.latitud, coordenadas.longitud);
  }

  // Encabezado mejorado con imagen y rating
  Widget _buildHeader(BuildContext context, Establishment establishment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageFullScreen(establishment.logoUrl),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                Image.network(
                  establishment.logoUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black54,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          establishment.nombre,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        _buildRating(establishment.puntuacion),
      ],
    );
  }

  // Sección de mapa e información de dirección en una sola línea
  Widget _buildMapSection(BuildContext context, Establishment establishment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.blueAccent),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  establishment.direccion,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  establishmentName: establishment.nombre,
                  location: _convertToLatLng(establishment.coordenadas),
                ),
              ),
            );
          },
          icon: Icon(Icons.map, size: 20),
          label: Text("Ver en Mapa"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  // Información de contacto con iconos más estilizados
  Widget _buildContactInfo(Establishment establishment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contacto'),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.phone, color: Colors.blueAccent),
          title: Text(establishment.telefono),
          onTap: () {
            // Aquí puedes agregar la lógica para abrir WhatsApp con el número
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.email, color: Colors.blueAccent),
          title: Text(establishment.email),
        ),
      ],
    );
  }

  // Información de horario
  Widget _buildOpeningHours(String horaApertura, String horaCierre) {
    final now = DateTime.now();
    final format = DateFormat('HH:mm');
    final apertura = format.parse(horaApertura);
    final cierre = format.parse(horaCierre);

    final aperturaHoy = DateTime(now.year, now.month, now.day, apertura.hour, apertura.minute);
    final cierreHoy = DateTime(now.year, now.month, now.day, cierre.hour, cierre.minute);
    final cierreAjustado = cierreHoy.isBefore(aperturaHoy) ? cierreHoy.add(Duration(days: 1)) : cierreHoy;

    bool isOpen = now.isAfter(aperturaHoy) && now.isBefore(cierreAjustado);
    String status = isOpen
        ? 'Abierto ahora, cierra a las $horaCierre'
        : 'Cerrado ahora, abre a las $horaApertura';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(isOpen ? Icons.check_circle : Icons.error, color: isOpen ? Colors.green : Colors.red),
      title: Text(
        status,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isOpen ? Colors.green : Colors.red),
      ),
    );
  }

  Widget _buildRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.orange, size: 24);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: Colors.orange, size: 24);
        } else {
          return Icon(Icons.star_border, color: Colors.orange, size: 24);
        }
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildTextWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildServices(List<Servicio> servicios) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: servicios.map((servicio) {
        return ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text(servicio.nombre),
          subtitle: Text(servicio.descripcion),
        );
      }).toList(),
    );
  }

  Widget _buildProducts(List<Producto> productos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productos.map((producto) {
        return ListTile(
          leading: Icon(Icons.shopping_bag, color: Colors.blueAccent),
          title: Text(producto.nombre),
          subtitle: Text('${producto.descripcion}\nPrecio: \$${producto.precio.toStringAsFixed(2)}'),
        );
      }).toList(),
    );
  }

  Widget _buildImages(BuildContext context, List<String> imagenes) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagenes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageFullScreen(imagenes[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imagenes[index],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  final String imageUrl;

  const ImageFullScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  final String establishmentName;
  final LatLng location;

  const MapScreen({required this.establishmentName, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(establishmentName),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(establishmentName),
            position: location,
            infoWindow: InfoWindow(title: establishmentName),
          ),
        },
      ),
    );
  }
}

