import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:turismo_app/domain/entities/entities.dart';

import '../../../infrastructure/providers/sitios/sitios_firestore.dart';

import '../../screens/screens.dart'; // Importa la pantalla de detalle del evento

class EventsSlideShow extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  EventsSlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FutureBuilder<List<Evento>>(
      future: firestoreService.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Evento>? eventos = snapshot.data;
          return eventos != null && eventos.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Eventos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: Swiper(
                        pagination: SwiperPagination(
                          margin: const EdgeInsets.only(top: 0),
                          builder: DotSwiperPaginationBuilder(
                            activeColor: colors.primary,
                            color: colors.secondary,
                          ),
                        ),
                        viewportFraction: 0.8,
                        scale: 0.6,
                        // autoplay: true,
                        itemCount: eventos.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            // Navega a la pantalla de detalles del evento
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailScreen(event: eventos[index]),
                              ),
                            );
                          },
                          child: _Slide(evento: eventos[index]),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(); // Devuelve un widget sin ocupar espacio
        }
      },
    );
  }
}

class _Slide extends StatelessWidget {
  final Evento evento;

  const _Slide({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/jar-loading.gif', // Ruta de la imagen de carga
            image: evento.img, // URL de la imagen del evento
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
