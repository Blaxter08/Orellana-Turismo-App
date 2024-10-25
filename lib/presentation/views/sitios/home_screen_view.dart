import 'package:flutter/material.dart';
import 'package:turismo_app/domain/entities/alimentos%20y%20bebidas/alimentos_bebidas_entidad.dart';
import 'package:turismo_app/presentation/widgets/alimentos%20y%20Bebidas/alimentos_bebidas_grid.dart';
import 'package:turismo_app/presentation/widgets/atractivo_turistico/atractivo_turistico_grid.dart';
import 'package:turismo_app/presentation/widgets/shared/customDrawer.dart';
import 'package:turismo_app/presentation/widgets/turismo%20comunitario/turismo_comunitario_grid.dart';
import '../../widgets/alojamiento Turistico/alojamiento_turistico_grid.dart';
import '../../widgets/categorias/categorias_slide_widtget.dart';
import '../../widgets/servicios_turistico/servicio_turistico_grid.dart'; // Widget para mostrar servicios turísticos

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
  ];

  String _categoriaSeleccionada = 'Atractivos turísticos'; // Por defecto se selecciona Atractivos turísticos
  String _query = ''; // Estado para la búsqueda

  // Método para actualizar la categoría seleccionada
  void _onCategoriaSeleccionada(String categoria) {
    setState(() {
      _categoriaSeleccionada = categoria;
      _query = ''; // Reiniciar la búsqueda cuando se cambia de categoría
    });
  }

  // Método para manejar la búsqueda
  void _onSearch(String query) {
    setState(() {
      _query = query.toLowerCase(); // Guardar la búsqueda en minúsculas para comparación
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Bienvenido a Orellana!'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de búsqueda
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar lugares, actividades...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: _onSearch, // Llamar al método de búsqueda cuando cambia el texto
              ),
              SizedBox(height: 16),

              // Slider de categorías con íconos y nombres
              CategorySliderWidget(
                categorias: categorias,
                onCategoriaSeleccionada: _onCategoriaSeleccionada, // Llamar cuando se selecciona una categoría
              ),

              SizedBox(height: 16),

              // Mostrar el grid según la categoría seleccionada
              if (_categoriaSeleccionada == 'Atractivos turísticos')
                AtractivosGridList(query: _query), // Mantener el diseño y modelo original
              if (_categoriaSeleccionada == 'Servicios turísticos')
                ServiciosTuristicosGrid(query: _query), // Pasar la búsqueda como parámetro
              if (_categoriaSeleccionada == 'Alojamiento turístico')
                AlojamientosTuristicosGrid(query: _query), // Mostrar la lista de alojamientos turísticos
              if (_categoriaSeleccionada == 'Alimentos y bebidas')
                AlimentosYBebidasGridList(query: _query), // Mostrar la lista de alojamientos turísticos
            if (_categoriaSeleccionada == 'Turismo comunitario')
                TurismoComunitarioGridList(query: _query), // Mostrar la lista de alojamientos turísticos
            ],
          ),
        ),
      ),
    );
  }
}
