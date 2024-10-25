import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategorySliderWidget extends StatelessWidget {
  final List<Map<String, String>> categorias;
  final Function(String) onCategoriaSeleccionada;

  CategorySliderWidget({required this.categorias, required this.onCategoriaSeleccionada});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categorias.map((categoria) {
          // Asignar íconos basados en la categoría
          IconData categoryIcon;
          switch (categoria['nombre']) {
            case 'Atractivos turísticos':
              categoryIcon = FontAwesomeIcons.city;
              break;
            case 'Alimentos y bebidas':
              categoryIcon = FontAwesomeIcons.utensils;
              break;
            case 'Servicios turísticos':
              categoryIcon = FontAwesomeIcons.servicestack;
              break;
            case 'Alojamiento turístico':
              categoryIcon = FontAwesomeIcons.hotel;
              break;
            case 'Turismo comunitario':
              categoryIcon = FontAwesomeIcons.bus;
              break;
            default:
              categoryIcon = FontAwesomeIcons.mapMarkedAlt;
          }

          return GestureDetector(
            onTap: () {
              onCategoriaSeleccionada(categoria['nombre']!); // Notificar la categoría seleccionada
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.shade300,
                  ),
                  child: FaIcon(
                    categoryIcon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                // Texto con dos líneas y puntos suspensivos si es necesario
                Container(
                  width: 80, // Ajustar ancho para controlar el texto en 2 líneas
                  child: Text(
                    categoria['nombre']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Limitar el texto a 2 líneas
                    overflow: TextOverflow.ellipsis, // Mostrar puntos suspensivos si el texto es largo
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
