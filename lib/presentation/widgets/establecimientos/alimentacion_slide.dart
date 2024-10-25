import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers/establecimientos/establishment_provider.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../screens/establecimientos/Establishments_detail_screen.dart';

class AlimentacionSlide extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final establecimientosAsync = ref.watch(alimentacionProvider);

    return establecimientosAsync.when(
      data: (establecimientos) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20), // Añadido espacio superior
            child: Text(
              'Alimentación y Bebidas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: establecimientos.length,
                itemBuilder: (context, index) {
                  final establishment = establecimientos[index];
                  return GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de detalles cuando se hace tap en un establecimiento
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EstablishmentDetailsScreen(
                            establishment: establishment, establishmentId: '',
                          ),
                        ),
                      );
                    },
                    child: _Slide(establishment: establishment),
                  );
                },
              ),
            ),
          ),
          // SizedBox(height: 2), // Espacio añadido entre categorías
        ],
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error al cargar establecimientos')),
    );
  }
}

class _Slide extends StatelessWidget {
  final Establishment establishment;

  const _Slide({
    Key? key,
    required this.establishment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
        children: [
          DecoratedBox(
            decoration: decoration,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage.assetNetwork(
                height: 100,
                width: 120,
                placeholder: 'assets/jar-loading.gif',
                image: establishment.logoUrl.isNotEmpty
                    ? establishment.logoUrl
                    : 'assets/no-image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              width: 120, // Ajustado al ancho de la imagen
              child: Text(
                establishment.nombre,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left, // Alineación a la izquierda
                maxLines: 2, // Permite un máximo de 2 líneas
                overflow: TextOverflow.ellipsis, // Si es muy largo, muestra puntos suspensivos
              ),
            ),
          ),
        ],
      ),
    );
  }
}
