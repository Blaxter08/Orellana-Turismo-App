import 'package:flutter/material.dart';
import 'package:turismo_app/domain/entities/sitios.dart';

class SitioCustomDetailScreen extends StatelessWidget {
  final Sitio sitio;

  const SitioCustomDetailScreen({Key? key, required this.sitio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [_CustomSliverAppBar(sitio: sitio)],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Sitio sitio;

  const _CustomSliverAppBar({super.key, required this.sitio});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          sitio.name,
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                sitio.img,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(
                          gradient: LinearGradient(
                              begin:Alignment.topCenter ,
                              end: Alignment.bottomCenter,
                              stops: [0.7,1.0],
                              colors: [
                                Colors.transparent,
                                Colors.black87,
                                      ]
                      )
                      )
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration:
                  BoxDecoration(
                      gradient: LinearGradient(
                          begin:Alignment.topLeft ,
                          stops: [0.0,0.3],
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                          ]
                      )
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
