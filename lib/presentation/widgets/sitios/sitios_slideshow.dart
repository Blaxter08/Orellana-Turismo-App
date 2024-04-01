import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:turismo_app/domain/entities/sitios.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';

import '../../providers/sitios/sitios_firestore.dart';
import '../../screens/screens.dart';
import '../../screens/sitios/sitios_custom_detail_screnn.dart';

class SitiosSlideShow extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final List<String> categorias = [
    'Hoteles',
    'Hostales',
    'Hosterias-Lodges',
  ];

  SitiosSlideShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 10
          ),
          child: Text(
            'Hospedaje',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.primary
            ),
          ),
        ),
        Container(
          height: 280,
          child: FutureBuilder<List<Sitio>>(
            future: firestoreService.getSitesByCategories(categorias),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Sitio> sitios = snapshot.data!;
                return Swiper(
                  viewportFraction: 0.85,
                  scale: 0.7,
                  autoplay: true,
                  itemCount: sitios.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SitioCustomDetailScreen(sitio: sitios[index]),
                        ),
                      );
                    },
                    child: _Slide(sitio: sitios[index]),
                  ),
                );
              }
            },
          ),
        ),
      ],
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
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );
    return Column(
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
