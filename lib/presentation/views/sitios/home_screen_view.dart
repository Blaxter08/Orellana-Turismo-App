// import 'package:flutter/material.dart';
// import 'package:turismo_app/presentation/widgets/alimentos%20y%20Bebidas/alimentos_bebidas_grid.dart';
// import 'package:turismo_app/presentation/widgets/atractivo_turistico/atractivo_turistico_grid.dart';
// import 'package:turismo_app/presentation/widgets/shared/custom%20drawer/customDrawer.dart';
// import 'package:turismo_app/presentation/widgets/turismo%20comunitario/turismo_comunitario_grid.dart';
// import '../../widgets/alojamiento Turistico/alojamiento_turistico_grid.dart';
// import '../../widgets/categorias/categorias_slide_widtget.dart';
// import '../../widgets/servicios_turistico/servicio_turistico_grid.dart';
// import '../../widgets/tour corto/tour_corto_grid_list.dart';
//
// class HomeScreenView extends StatefulWidget {
//   @override
//   _HomeScreenViewState createState() => _HomeScreenViewState();
// }
//
// class _HomeScreenViewState extends State<HomeScreenView> {
//   final List<Map<String, String>> categorias = [
//     {'nombre': 'Atractivos turísticos'},
//     {'nombre': 'Alimentos y bebidas'},
//     {'nombre': 'Servicios turísticos'},
//     {'nombre': 'Alojamiento turístico'},
//     {'nombre': 'Turismo comunitario'},
//     {'nombre': 'Tours Cortos'},
//   ];
//
//   String _categoriaSeleccionada = 'Atractivos turísticos';
//   String _query = '';
//
//   void _onCategoriaSeleccionada(String categoria) {
//     setState(() {
//       _categoriaSeleccionada = categoria;
//       _query = '';
//     });
//   }
//
//   void _onSearch(String query) {
//     setState(() {
//       _query = query.toLowerCase();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         elevation: 0, // Quita la sombra para que se integre al diseño del banner
//         backgroundColor: Colors.transparent, // Fondo transparente para que sea consistente
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.teal.shade400,
//                 Colors.teal.shade300,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.place_outlined,
//               color: Colors.white,
//               size: 24,
//             ),
//             SizedBox(width: 8),
//             Text(
//               'El Coca Vívelo',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.notifications_outlined,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Acción para notificaciones
//             },
//           ),
//         ],
//       ),
//
//       drawer: CustomDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Sección de bienvenida
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.teal.shade400,
//                     Colors.teal.shade300,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: Offset(0, 5), // Sombra hacia abajo
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Explora las maravillas de El Coca',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Encuentra atractivos turísticos, alimentos y bebidas, servicios y más.',
//                     style: TextStyle(fontSize: 16, color: Colors.white70),
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Buscar lugares, actividades...',
//                         prefixIcon: Icon(Icons.search, color: Colors.teal.shade600),
//                         border: InputBorder.none,
//                         isDense: true, // Reduce el tamaño del TextField
//                         contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Centrado más preciso
//                       ),
//                       style: TextStyle(fontSize: 16), // Ajusta el tamaño del texto
//                       onChanged: _onSearch,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 16),
//
//             // Slider de categorías
//             CategorySliderWidget(
//               categorias: categorias,
//               onCategoriaSeleccionada: _onCategoriaSeleccionada,
//             ),
//
//             SizedBox(height: 16),
//
//             // Grid dinámico según la categoría seleccionada
//             _buildCategoryContent(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryContent() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           if (_categoriaSeleccionada == 'Atractivos turísticos')
//             AtractivosGridList(query: _query),
//           if (_categoriaSeleccionada == 'Alimentos y bebidas')
//             AlimentosYBebidasGridList(query: _query),
//           if (_categoriaSeleccionada == 'Servicios turísticos')
//             ServiciosTuristicosGrid(query: _query),
//           if (_categoriaSeleccionada == 'Alojamiento turístico')
//             AlojamientosTuristicosGrid(query: _query),
//           if (_categoriaSeleccionada == 'Turismo comunitario')
//             TurismoComunitarioGridList(query: _query),
//           if (_categoriaSeleccionada == 'Tours Cortos')
//             ToursCortosGrid(query: _query), // Placeholder para tours cortos
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../infrastructure/providers/evento/event_provider.dart';
import '../../widgets/alojamiento Turistico/alojamiento_turistico_grid.dart';
import '../../widgets/alimentos y Bebidas/alimentos_bebidas_grid.dart';
import '../../widgets/atractivo_turistico/atractivo_turistico_grid.dart';
import '../../widgets/eventos/event_slide.dart';
import '../../widgets/tour corto/tour_corto_grid_list.dart';
import '../../widgets/shared/custom drawer/customDrawer.dart';
import '../../widgets/categorias/categorias_slide_widtget.dart';
import '../../widgets/servicios_turistico/servicio_turistico_grid.dart';
import '../../widgets/turismo comunitario/turismo_comunitario_grid.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final List<Map<String, String>> categorias = [
    {'nombre': 'Atractivos turísticos'},
    {'nombre': 'Alimentos y bebidas'},
    {'nombre': 'Servicios turísticos'},
    {'nombre': 'Alojamiento turístico'},
    {'nombre': 'Turismo comunitario'},
    {'nombre': 'Tours Cortos'},
  ];

  String _categoriaSeleccionada = 'Atractivos turísticos';
  String _query = '';

  void _onCategoriaSeleccionada(String categoria) {
    setState(() {
      _categoriaSeleccionada = categoria;
      _query = '';
    });
  }

  void _onSearch(String query) {
    setState(() {
      _query = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade400,
                Colors.teal.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.place_outlined, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'El Coca Vívelo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de bienvenida
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade400,
                    Colors.teal.shade300,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explora las maravillas de El Coca',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Encuentra atractivos turísticos, alimentos y bebidas, servicios y más.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar lugares, actividades...',
                        prefixIcon: Icon(Icons.search, color: Colors.teal.shade600),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                      style: TextStyle(fontSize: 16),
                      onChanged: _onSearch,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Slider de eventos
            Consumer(
              builder: (context, ref, _) {
                final eventosAsync = ref.watch(eventosProvider);

                return eventosAsync.when(
                  data: (eventos) {
                    // Si no hay eventos disponibles, retorna un widget vacío
                    if (eventos.isEmpty) {
                      return SizedBox.shrink(); // No renderiza nada
                    }
                    // Si hay eventos, muestra el EventSlide
                    return EventSlide(events: eventos);
                  },
                  loading: () => Center(child: CircularProgressIndicator()), // Opcional, se muestra mientras carga
                  error: (err, stack) => SizedBox.shrink(), // No muestra nada en caso de error
                );
              },
            ),

            SizedBox(height: 16),

            // Slider de categorías
            CategorySliderWidget(
              categorias: categorias,
              onCategoriaSeleccionada: _onCategoriaSeleccionada,
            ),

            SizedBox(height: 16),

            // Grid dinámico según la categoría seleccionada
            _buildCategoryContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          if (_categoriaSeleccionada == 'Atractivos turísticos')
            AtractivosGridList(query: _query),
          if (_categoriaSeleccionada == 'Alimentos y bebidas')
            AlimentosYBebidasGridList(query: _query),
          if (_categoriaSeleccionada == 'Servicios turísticos')
            ServiciosTuristicosGrid(query: _query),
          if (_categoriaSeleccionada == 'Alojamiento turístico')
            AlojamientosTuristicosGrid(query: _query),
          if (_categoriaSeleccionada == 'Turismo comunitario')
            TurismoComunitarioGridList(query: _query),
          if (_categoriaSeleccionada == 'Tours Cortos')
            ToursCortosGrid(query: _query),
        ],
      ),
    );
  }
}
