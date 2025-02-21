import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/localizacion/firestore_service_consult.dart';

final categoriaProvider = StateProvider<String>((ref) => 'Atractivos Turísticos');

final Map<String, String> coleccionesFirestore = {
  'Atractivos Turísticos': 'atractivosTuristicos',
  'Hospedaje': 'alojamientosTuristicos',
  'Alimentación': 'alimentosYBebidas',
  'Servicios': 'serviciosTuristicos',
  'Turismo Comunitario': 'turismosComunitario',
};

// 🔹 Función para asignar color a los iconos de Google Maps según la categoría
BitmapDescriptor getCategoryIcon(String categoria, double puntuacion) {
  double hueColor;

  // 🔥 Colores según la categoría
  switch (categoria) {
    case 'Atractivos Turísticos':
      hueColor = BitmapDescriptor.hueGreen; // Azul
      break;
    case 'Hospedaje':
      hueColor = BitmapDescriptor.hueBlue; // Rojo
      break;
    case 'Alimentación':
      hueColor = BitmapDescriptor.hueOrange; // Naranja
      break;
    case 'Servicios':
      hueColor = BitmapDescriptor.hueViolet; // Amarillo
      break;
    case 'Turismo Comunitario':
      hueColor = BitmapDescriptor.hueGreen; // Verde
      break;
    default:
      hueColor = BitmapDescriptor.hueBlue; // Color por defecto
  }

  // 🔥 Si el lugar tiene 5 estrellas, usa un icono especial más grande
  if (puntuacion == 5.0) {
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta); // Rosa para destacar
  }

  return BitmapDescriptor.defaultMarkerWithHue(hueColor);
}

final marcadoresProvider = FutureProvider<List<Marker>>((ref) async {
  final String categoria = ref.watch(categoriaProvider);
  final String? coleccion = coleccionesFirestore[categoria];

  if (coleccion == null) {
    print("❌ Error: No se encontró la colección para la categoría '$categoria'");
    return [];
  }

  final firestoreService = FirestoreService();
  final List<Map<String, dynamic>> lugares = await firestoreService.getLugares(coleccion);

  if (lugares.isEmpty) {
    print("⚠️ No se encontraron lugares en la colección: $coleccion");
    return [];
  }

  List<Marker> marcadores = [];

  for (var lugar in lugares) {
    List<double> coordenadas = lugar["coordenadas"];

    if (coordenadas[0] == 0.0 && coordenadas[1] == 0.0) {
      print("⚠️ Coordenadas inválidas para: ${lugar["nombre"]}");
      continue;
    }

    double puntuacion = lugar.containsKey("puntuacion") ? (lugar["puntuacion"] as num).toDouble() : 0.0;

    print("📍 Creando marcador para: ${lugar["nombre"]} en (${coordenadas[0]}, ${coordenadas[1]}) con puntuación: $puntuacion");

    String puntuacionTexto = puntuacion > 0 ? "⭐ ${puntuacion.toStringAsFixed(1)}" : "Sin calificación";

    marcadores.add(
      Marker(
        markerId: MarkerId(lugar["id"]),
        position: LatLng(coordenadas[0], coordenadas[1]),
        infoWindow: InfoWindow(
          title: lugar["nombre"],
          snippet: "${lugar["descripcion"]}\n$puntuacionTexto",
        ),
        icon: getCategoryIcon(categoria, puntuacion), // 🔥 Usa el icono con color personalizado
      ),
    );
  }

  print("✅ Total de marcadores generados: ${marcadores.length}");
  return marcadores;
});
