import 'package:flutter/material.dart';
import 'package:turismo_app/domain/entities/entities.dart';

class SitioHorizontalListview extends StatelessWidget {
  final List<Sitio> sitios;
  final String? tittle;
  final String? subtittle;
  final VoidCallback? loadNetxPage;

  const SitioHorizontalListview(
      {super.key,
      required this.sitios,
      required this.tittle,
      required this.subtittle,
      required,
      this.loadNetxPage});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
