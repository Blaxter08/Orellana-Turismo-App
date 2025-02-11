import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/tour corto/tour_corto.dart';

class TourCortoDetailScreen extends StatelessWidget {
  final TourCorto tour;

  TourCortoDetailScreen({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tour.nombre,
                style: const TextStyle(color: Colors.white),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: tour.logo,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.grey[300]),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 100),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Detalle principal
                  Text(
                    tour.nombre,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(
                        'Duración: ${tour.tiempo}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tour.detalle,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  const Divider(height: 32),
                  // Sección de costo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Costo por persona:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${tour.costo}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  // Contactos
                  const Text(
                    'Contactos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...tour.contactos.map(
                        (contacto) => ListTile(
                      leading: const Icon(Icons.phone, color: Colors.teal),
                      title: Text(contacto.nombreAgencia),
                      subtitle: Text(contacto.telefono),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.teal),
                        onPressed: () {
                          // Llamada telefónica
                          _callPhoneNumber(contacto.telefono);
                        },
                      ),
                    ),
                  ),
                  const Divider(height: 32),
                  // Galería de imágenes
                  const Text(
                    'Galería',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tour.imagenes.length,
                      itemBuilder: (context, index) {
                        final imageUrl = tour.imagenes[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.grey[300]),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botón de reservar
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Lógica de reserva
                      },
                      icon: const Icon(Icons.event_available),
                      label: const Text('Reservar Ahora'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callPhoneNumber(String phoneNumber) {
    // Implementar lógica para realizar una llamada telefónica
  }
}
