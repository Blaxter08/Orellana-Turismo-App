import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turismo_app/domain/entities/sitios.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';

import '../../../infrastructure/providers/sitios/sitiosNotifier.dart';
import '../../screens/sitios/sitios_custom_detail_screnn.dart';

class SitiosSlideShow extends ConsumerWidget {
  SitiosSlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sitios = ref.watch(sitiosProvider);
    final isLoading = ref.watch(sitiosProvider.notifier).isLoading;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Hospedaje',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5,),
        SizedBox(
          height: 280,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                ref.read(sitiosProvider.notifier).loadSites();
              }
              return true;
            },
            child: Swiper(
              viewportFraction: 0.85,
              scale: 0.7,
              autoplay: false,
              itemCount: sitios.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SitioCustomDetailScreen(
                          sitio: sitios[index],
                          sitioId: sitios[index].idSitio

                      ),
                    ),
                  );
                },
                child: _Slide(sitio: sitios[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





// class _Slide extends StatelessWidget {
//   final Sitio sitio;
//
//   const _Slide({
//     Key? key,
//     required this.sitio,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const decoration = BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black45,
//           blurRadius: 10,
//           offset: Offset(0, 10),
//         ),
//       ],
//     );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         DecoratedBox(
//           decoration: decoration,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: FadeInImage.assetNetwork(
//               height: 180,
//               width: double.infinity,
//               placeholder: 'assets/jar-loading.gif',
//               image: sitio.img,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(height: 15),
//         Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Text(
//             sitio.name,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.start,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: StarRating(rating: sitio.puntuation),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Text(
//             sitio.direction,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ],
//     );
//   }
// }
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
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );

    return AnimatedOpacity(
      duration: Duration(milliseconds: 500), // Duración de la animación
      opacity: 1, // Puede variar de 0 a 1 para controlar la opacidad
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: decoration,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                height: 180,
                width: double.infinity,
                placeholder: 'assets/jar-loading.gif',
                image: sitio.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              sitio.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: StarRating(rating: sitio.puntuation),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              sitio.direction,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
