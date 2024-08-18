import 'package:cloud_firestore/cloud_firestore.dart';

class Sitio {
  final String idSitio;
  final String name;
  final String img;
  final String description;
  final String direction;
  final int puntuation;
  final DocumentReference category; // Cambiado a DocumentReference
  final String telefono;
  final List<String> services;
  String categoryName; // Campo para almacenar el nombre de la categoría

  Sitio({
    required this.idSitio,
    required this.name,
    required this.direction,
    required this.puntuation,
    required this.telefono,
    required this.img,
    required this.description,
    required this.category, // Cambiado a DocumentReference
    required this.services,
    required this.categoryName,
  });

  factory Sitio.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final categoryRef = data['category'] as DocumentReference; // Obtener la referencia al documento de categoría
    return Sitio(
      idSitio: data['idSitio'] ?? '',
      name: data['name'] ?? '',
      direction: data['direction'] ?? '',
      puntuation: data['puntuation'] ?? 0,
      telefono: data['telefono'] ?? '',
      img: data['img'] ?? '',
      description: data['description'] ?? '',
      category: categoryRef, // Usar la referencia al documento de categoría
      services: List<String>.from(data['services'] ?? []),
      categoryName: '', // Inicializar categoryName
    );
  }

  Future<void> getCategoryName() async {
    final categoryDoc = await category.get();
    if (categoryDoc.exists) {
      final data = categoryDoc.data() as Map<String, dynamic>; // Convertir a Map<String, dynamic>
      categoryName = data['name_cat'] ?? '';
    }
  }

}
