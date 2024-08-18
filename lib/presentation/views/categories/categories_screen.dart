import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const name = 'categories-screen';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CategoryItem(
            title: 'Alimentos & Bebidas',
            icon: Icons.restaurant,
            color: Colors.orange,
          ),
          _CategoryItem(
            title: 'Hospedaje',
            icon: Icons.hotel,
            color: Colors.blue,
          ),
          _CategoryItem(
            title: 'Transporte & Turismo',
            icon: Icons.directions_car,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Aquí podrías navegar a una pantalla específica según la categoría seleccionada
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
