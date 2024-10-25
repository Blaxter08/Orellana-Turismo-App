import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/widgets.dart';
import '../../../domain/entities/establecimientos.dart';

class EstablishmentDetailScreen extends StatelessWidget {
  final Establishment establishment;
  final String establishmentId;

  const EstablishmentDetailScreen({
    Key? key,
    required this.establishment,
    required this.establishmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(establishment: establishment),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _EstablishmentDetails(
                establishment: establishment,
                establishmentId: establishmentId,
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _EstablishmentDetails extends StatelessWidget {
  final Establishment establishment;
  final String establishmentId;

  const _EstablishmentDetails({
    Key? key,
    required this.establishment,
    required this.establishmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOpen = true; // Suponiendo que siempre está abierto, ajusta según la lógica

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            establishment.nombre,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  establishment.direccion,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(isOpen ? Icons.access_time : Icons.lock,
                  color: isOpen ? Colors.green : Colors.red),
              SizedBox(width: 5),
              Text(
                isOpen ? "Abierto ahora" : "Cerrado ahora",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              final latitude = establishment.coordenadas.latitud;
              final longitude = establishment.coordenadas.longitud;

              final Uri googleMapsUri = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

              if (await canLaunchUrl(googleMapsUri)) {
                await launchUrl(googleMapsUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No se pudo abrir Google Maps')));
              }
            },
            icon: Icon(Icons.map),
            label: Text('Ver en Google Maps'),
          ),
          SizedBox(height: 10),
          _buildTabBar(),
          SizedBox(height: 20),
          _buildProductosWidget(establishment),  // Productos o Habitaciones según la categoría
          SizedBox(height: 20),
          _buildImagenesWidget(establishment),  // Muestra las imágenes
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Descripción'),
              Tab(text: 'Servicios'),
              Tab(text: 'Comentarios'),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200, // Ajusta la altura según sea necesario para acomodar el contenido
            child: TabBarView(
              children: [
                _DescripcionWidget(description: establishment.categoriaPrincipal),
                _ServiciosWidget(servicios: establishment.servicios),
                ComentariosWidget(establishmentId: establishmentId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductosWidget(Establishment establishment) {
    String titulo = establishment.categoriaPrincipal == "Alimentación"
        ? "Alimentos"
        : "Habitaciones";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: establishment.productos.map((producto) {
            return Container(
              width: 180,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto.nombre,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        producto.descripcion,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$${producto.precio.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImagenesWidget(Establishment establishment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Imágenes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: establishment.imagenes.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DescripcionWidget extends StatelessWidget {
  final String description;

  const _DescripcionWidget({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: GoogleFonts.roboto(
            fontSize: 17,
            color: Colors.grey,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _ServiciosWidget extends StatelessWidget {
  final List<Servicio> servicios;

  const _ServiciosWidget({Key? key, required this.servicios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Mostrar 2 tarjetas por fila
        childAspectRatio: 3 / 2, // Relación de aspecto de las tarjetas
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      physics: NeverScrollableScrollPhysics(), // Evitar el scroll dentro del GridView
      shrinkWrap: true, // Ajustar el tamaño del GridView según su contenido
      itemCount: servicios.length,
      itemBuilder: (context, index) {
        final servicio = servicios[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(height: 8),
                Text(
                  servicio.nombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  servicio.descripcion,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Establishment establishment;

  const _CustomSliverAppBar({Key? key, required this.establishment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: size.height * 0.3,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                establishment.logoUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [Colors.transparent, Colors.black45],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black38, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
