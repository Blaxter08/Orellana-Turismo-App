import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/widgets.dart';
import 'package:turismo_app/domain/entities/sitios.dart';

import '../../providers/sitios/sitios_firestore.dart';
import '../../screens/screens.dart';

class ComidasBebidas_SlideShow extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final List<String> categorias = ['Restaurantes', 'Cafeterías', 'Bares & Discotecas'];

  ComidasBebidas_SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20
          ),
          child: Text(
            'Comidas y Bebidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
                color: colors.primary
            ),
          ),
        ),
        Container(
          height: 120,
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
                  viewportFraction: 0.3,
                  scale: 0.5,
                  itemCount: sitios.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SitioDetailScreen(sitio: sitios[index]),
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

class _Slide extends StatefulWidget {
  final Sitio sitio;

  const _Slide({
    Key? key,
    required this.sitio,
  }) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
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
        Stack(
          children: [
            DecoratedBox(
              decoration: decoration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  height: 80,
                  width: double.infinity,
                  placeholder: 'assets/jar-loading.gif',
                  image: widget.sitio.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: -13,
              right:-13,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  // Aquí puedes implementar la lógica para guardar o quitar el sitio de la lista de favoritos.
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black54,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Expanded(
          child: Text(
            widget.sitio.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
