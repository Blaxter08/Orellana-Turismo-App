import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/domain/entities/sitios.dart';
import 'package:turismo_app/presentation/screens/sitios/sitios_custom_detail_screnn.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';
import '../../../infrastructure/providers/sitios/comidas_bedidas_Notifier.dart';
import '../../screens/screens.dart';// Importa el proveedor aquí


class ComidasBebidas_SlideShow extends ConsumerWidget {
  ComidasBebidas_SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final sitiosAsyncValue = ref.watch(comidasBebidasSlideShowProvider); // Usa watch para acceder al proveedor

    return sitiosAsyncValue.when(
      loading: () => Center(
        child: Container(
          // width: 50,
          // height: 50,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(25),
          //   border: Border.all(color: Color(0x47000000)),
          // ),
        ),
      ),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (sitios) {
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
                  itemCount: sitios.length,
                  itemBuilder: (context, index) {
                    Sitio sitio = sitios[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SitioCustomDetailScreen(sitio: sitio, sitioId: sitio.idSitio,),
                          ),
                        );
                      },
                      child: _Slide(sitio: sitio),
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
  final Sitio sitio;

  const _Slide({
    Key? key,
    required this.sitio,
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
                image: sitio.img.isNotEmpty ? sitio.img : 'assets/no-image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            sitio.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
