import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating; // Valor numérico de la puntuación
  final int maxRating; // Puntuación máxima (por defecto 5)
  final IconData filledStar; // Icono para estrella llena (por defecto Icons.star)
  final IconData unfilledStar; // Icono para estrella vacía (por defecto Icons.star_border)
  final double starSize; // Tamaño de las estrellas (por defecto 20.0)
  final Color color; // Color de las estrellas (por defecto Colors.amber)

  const StarRating({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.filledStar = Icons.star,
    this.unfilledStar = Icons.star_border,
    this.starSize = 20.0,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        if (index < rating) {
          return Icon(
            filledStar,
            size: starSize,
            color: color,
          );
        } else {
          return Icon(
            unfilledStar,
            size: starSize,
            color: color,
          );
        }
      }),
    );
  }
}
