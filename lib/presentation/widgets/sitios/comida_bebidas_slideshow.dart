import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/domain/entities/establecimientos.dart'; // Cambiado a Establishment
import 'package:turismo_app/presentation/screens/sitios/sitios_custom_detail_screnn.dart'; // Asegúrate de que esté importado correctamente
import 'package:turismo_app/presentation/widgets/widgets.dart';
import '../../../infrastructure/providers/sitios/comidas_bedidas_Notifier.dart';
import '../../screens/screens.dart';

class ComidasBebidas_SlideShow extends ConsumerWidget {
  ComidasBebidas_SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sitiosAsyncValue = ref.watch(comidasBebidasSlideShowProvider);

    return sitiosAsyncValue.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (establecimientos) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Alimentos y bebidas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                    Establishment establishment = establecimientos[index] as Establishment;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EstablishmentDetailScreen(
                              establishment: establishment,
                              establishmentId: establishment.id,
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
          ],
        );
      },
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Text(
            establishment.nombre,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
