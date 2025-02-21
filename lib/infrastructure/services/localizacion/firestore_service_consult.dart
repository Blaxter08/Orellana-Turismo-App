import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getLugares(String coleccion) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection(coleccion).get();

      print("📊 Documentos encontrados en la colección '$coleccion': ${querySnapshot.docs.length}");

      List<Map<String, dynamic>> lugares = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return {
          "id": doc.id,
          "nombre": data["nombre"] ?? "Sin nombre",
          "direccion": data["direccion"] ?? "Sin nombre",
          "descripcion": data.containsKey("descripcion") ? data["descripcion"] : "Sin descripción",  // 🔹 EVITA EL ERROR
          "coordenadas": (data["coordenadas"] is List && (data["coordenadas"] as List).length == 2)
              ? List<double>.from((data["coordenadas"] as List<dynamic>).map((e) => (e as num).toDouble()))
              : [0.0, 0.0], // 🔹 ASIGNA COORDENADAS POR DEFECTO SI SON INVÁLIDAS
          "puntuacion": data.containsKey("puntuacion") ? (data["puntuacion"] as num).toDouble() : 0.0,  // 🔥 AÑADE PUNTUACIÓN SEGURA
        };
      }).toList();

      print("✅ Lugares obtenidos correctamente: ${lugares.length}");
      return lugares;
    } catch (e) {
      print("❌ Error al obtener lugares desde Firestore: $e");
      return [];
    }
  }
}
