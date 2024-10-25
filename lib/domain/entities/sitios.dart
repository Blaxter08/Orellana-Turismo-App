// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Sitio {
//   final String idSitio;
//   final String name;
//   final String img;
//   final String description;
//   final String direction;
//   final int puntuation;
//   final DocumentReference category; // Cambiado a DocumentReference
//   final String telefono;
//   final List<String> services;
//   String categoryName; // Campo para almacenar el nombre de la categoría
//
//   Sitio({
//     required this.idSitio,
//     required this.name,
//     required this.direction,
//     required this.puntuation,
//     required this.telefono,
//     required this.img,
//     required this.description,
//     required this.category, // Cambiado a DocumentReference
//     required this.services,
//     required this.categoryName,
//   });
//
//   factory Sitio.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     final categoryRef = data['category'] as DocumentReference; // Obtener la referencia al documento de categoría
//     return Sitio(
//       idSitio: data['idSitio'] ?? '',
//       name: data['name'] ?? '',
//       direction: data['direction'] ?? '',
//       puntuation: data['puntuation'] ?? 0,
//       telefono: data['telefono'] ?? '',
//       img: data['img'] ?? '',
//       description: data['description'] ?? '',
//       category: categoryRef, // Usar la referencia al documento de categoría
//       services: List<String>.from(data['services'] ?? []),
//       categoryName: '', // Inicializar categoryName
//     );
//   }
//
//   Future<void> getCategoryName() async {
//     final categoryDoc = await category.get();
//     if (categoryDoc.exists) {
//       final data = categoryDoc.data() as Map<String, dynamic>; // Convertir a Map<String, dynamic>
//       categoryName = data['name_cat'] ?? '';
//     }
//   }
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../presentation/widgets/widgets.dart';

class Sitio {
  final String idSitio;
  final String name;
  final String img;
  final String description;
  final String direction;
  final int puntuation;
  final DocumentReference category;
  final String telefono;
  final List<String> services;
  String categoryName;
  final double latitude; // Coordenada de latitud
  final double longitude; // Coordenada de longitud
  final String openingTime; // Hora de apertura
  final String closingTime; // Hora de cierre

  Sitio({
    required this.idSitio,
    required this.name,
    required this.direction,
    required this.puntuation,
    required this.telefono,
    required this.img,
    required this.description,
    required this.category,
    required this.services,
    required this.categoryName,
    required this.latitude,
    required this.longitude,
    required this.openingTime,
    required this.closingTime,
  });

  factory Sitio.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final categoryRef = data['category'] as DocumentReference;
    return Sitio(
      idSitio: data['idSitio'] ?? '',
      name: data['name'] ?? '',
      direction: data['direction'] ?? '',
      puntuation: data['puntuation'] ?? 0,
      telefono: data['telefono'] ?? '',
      img: data['img'] ?? '',
      description: data['description'] ?? '',
      category: categoryRef,
      services: List<String>.from(data['services'] ?? []),
      categoryName: '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
      openingTime: data['openingTime'] ?? '00:00',
      closingTime: data['closingTime'] ?? '23:59',
    );
  }

  Future<void> getCategoryName() async {
    final categoryDoc = await category.get();
    if (categoryDoc.exists) {
      final data = categoryDoc.data() as Map<String, dynamic>;
      categoryName = data['name_cat'] ?? '';
    }
  }

  bool isOpen() {
    final now = TimeOfDay.now();
    final opening = _parseTime(openingTime);
    final closing = _parseTime(closingTime);

    if (closing.hour < opening.hour) {
      // Horario que cruza la medianoche
      return (now.hour > opening.hour || (now.hour == opening.hour && now.minute >= opening.minute)) ||
          (now.hour < closing.hour || (now.hour == closing.hour && now.minute < closing.minute));
    } else {
      // Horario normal
      return (now.hour > opening.hour || (now.hour == opening.hour && now.minute >= opening.minute)) &&
          (now.hour < closing.hour || (now.hour == closing.hour && now.minute < closing.minute));
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }


}
