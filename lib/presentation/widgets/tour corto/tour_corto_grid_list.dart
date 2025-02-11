import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../infrastructure/providers/tour corto/tour_corto_provider.dart';
import '../../screens/tour corto/tour_corto_detail_screen.dart';

class ToursCortosGrid extends ConsumerWidget {
  final String query;

  ToursCortosGrid({required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toursCortosAsyncValue = ref.watch(toursCortosProvider);

    return toursCortosAsyncValue.when(
      data: (toursCortos) {
        final filtrados = toursCortos.where((tour) {
          final nombre = tour.nombre.toLowerCase();
          final detalle = tour.detalle.toLowerCase();
          return nombre.contains(query) || detalle.contains(query);
        }).toList();

        return filtrados.isNotEmpty
            ? GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: filtrados.length,
          itemBuilder: (context, index) {
            final tour = filtrados[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TourCortoDetailScreen(tour: tour),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    // Imagen con CachedNetworkImage
                    CachedNetworkImage(
                      imageUrl: tour.logo,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      fadeInDuration: const Duration(milliseconds: 500),
                    ),
                    // Sombra degradada con texto
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tour.nombre,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tour.tiempo,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${tour.costo}',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : const Center(child: Text('No hay tours cortos disponibles.'));
      },
      loading: () => _buildSkeletonLoader(),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  // Skeleton Loader
  Widget _buildSkeletonLoader() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 15,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 4),
                Container(
                  width: 150,
                  height: 15,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
