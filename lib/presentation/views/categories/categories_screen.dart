import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../screens/routes_list/route_list.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  static const name = 'categories-screen';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'), // Cambia esto para traducir el título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 3 / 2,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final categories = [
              CategoryItem(
                getTitle: () => S.of(context).food_drinks,  // Función que devuelve el texto
                icon: Icons.restaurant,
                color: Colors.orange,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EstablishmentsListScreen(
                        category: S.of(context).food_drinks,
                      ),
                    ),
                  );
                },
              ),
              CategoryItem(
                getTitle: () => S.of(context).Lodging,  // Función que devuelve el texto
                icon: Icons.hotel,
                color: Colors.blue,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EstablishmentsListScreen(
                        category: S.of(context).Lodging,
                      ),
                    ),
                  );
                },
              ),
              CategoryItem(
                getTitle: () => S.of(context).transport_tourism,
                icon: Icons.directions_car,
                color: Colors.green,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EstablishmentsListScreen(
                        category: S.of(context).transport_tourism,
                      ),
                    ),
                  );
                },
              ),
              CategoryItem(
                getTitle: () => S.of(context).tourist_routes,
                icon: Icons.map,
                color: Colors.red,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RutasTuristicasScreen(),
                    ),
                  );
                },
              ),
            ];

            return categories[index];
          },
        ),
      ),
    );
  }
}

