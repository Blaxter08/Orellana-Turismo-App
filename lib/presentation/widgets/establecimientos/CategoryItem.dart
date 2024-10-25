import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String Function() getTitle;  // Función que devuelve el texto
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.getTitle,  // Cambiado a función
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                getTitle(),  // Llama a la función para obtener el texto
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
