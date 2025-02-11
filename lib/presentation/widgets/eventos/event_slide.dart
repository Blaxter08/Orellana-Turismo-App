import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/evento/evento_model.dart';

class EventSlide extends StatelessWidget {
  final List<Event> events;

  EventSlide({required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Swiper(
        itemCount: events.length,
        autoplay: true,
        autoplayDelay: 5000,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.teal,
            color: Colors.grey,
          ),
        ),
        itemBuilder: (context, index) {
          final event = events[index];
          return _buildEventCard(context, event);
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    return GestureDetector(
      onTap: () {
        // Acción al tocar un evento
        _showEventDetails(context, event);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fecha: ${event.startDate.toLocal()}'.split(' ')[0],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: event.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            Text('Fecha: ${event.startDate.toLocal()}'),
            const SizedBox(height: 4),
            Text('Ubicación: ${event.location}'),
            const SizedBox(height: 4),
            Text('Descripción: ${event.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
