import 'package:flutter/material.dart';

class CategorySliderWidget extends StatelessWidget {
  final List<Map<String, String>> categorias;
  final Function(String) onCategoriaSeleccionada;

  CategorySliderWidget({required this.categorias, required this.onCategoriaSeleccionada});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categorias.map((categoria) {
          // Asignar rutas de imágenes basadas en la categoría
          String categoryImage;
          switch (categoria['nombre']) {
            case 'Atractivos turísticos':
              categoryImage = 'assets/categories/mapa.png';
              break;
            case 'Alimentos y bebidas':
              categoryImage = 'assets/categories/restaurante-c.png';
              break;
            case 'Servicios turísticos':
              categoryImage = 'assets/categories/folleto.png';
              break;
            case 'Alojamiento turístico':
              categoryImage = 'assets/categories/alojamiento.png';
              break;
            case 'Turismo comunitario':
              categoryImage = 'assets/categories/transporte.png';
              break;
            case 'Tours Cortos':
              categoryImage = 'assets/categories/ruta-de-vuelo.png';
              break;
            default:
              categoryImage = 'assets/images/default.png';
          }

          return GestureDetector(
            onTap: () {
              onCategoriaSeleccionada(categoria['nombre']!); // Notificar la categoría seleccionada
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Column(
                children: [
                  Container(
                    width: 70, // Tamaño más grande para las imágenes
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                      color: Colors.teal.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5), // Sombra hacia abajo
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        categoryImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 80, // Ancho fijo para el texto
                    child: Text(
                      categoria['nombre']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
