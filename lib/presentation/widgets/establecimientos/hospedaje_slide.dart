import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../infrastructure/providers/establecimientos/establishment_provider.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../screens/establecimientos/Establishments_detail_screen.dart';
import '../shared/star_rating.dart';

class HospedajeHorizontalList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final establecimientosAsync = ref.watch(hospedajeProvider);

    return establecimientosAsync.when(
      data: (establecimientos) {
        if (establecimientos.isEmpty) {
          return Center(
            child: Text('No hay establecimientos disponibles'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Hospedaje Destacado',
                style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 240, // Ajuste de la altura
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: establecimientos.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final establishment = establecimientos[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EstablishmentDetailsScreen(
                            establishment: establishment,
                            establishmentId: '',
                          ),
                        ),
                      );
                    },
                    child: _CustomCard(establishment: establishment),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error al cargar establecimientos')),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final Establishment establishment;

  const _CustomCard({
    Key? key,
    required this.establishment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FadeInImage.assetNetwork(
                  height: 180,
                  width: double.infinity,
                  placeholder: 'assets/jar-loading.gif',
                  image: establishment.logoUrl ?? '',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/default-image.png',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        StarRating(rating: establishment.puntuacion?.toInt() ?? 0),
                        SizedBox(width: 5),
                        Text(
                          establishment.puntuacion?.toString() ?? '0',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.teal.shade300,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      establishment.nombre ?? 'Nombre no disponible',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // color: Colors.teal[800],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 17, color: Colors.red),
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            establishment.direccion ?? 'Dirección no disponible',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade300,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
