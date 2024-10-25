import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/alojamientos turisticos/alojamientos_turisiticos_entidad.dart';

class AlojamientoTuristicoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  // Método para obtener los alojamientos turísticos en tiempo real desde Firestore
  Stream<List<AlojamientoTuristico>> fetchAlojamientosTuristicos() {
    return firestore.collection('alojamientosTuristicos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Pasar el ID del documento y el snapshot como parámetros a fromJson
        return AlojamientoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc.id, doc);
      }).toList();
    });
  }

  // Método para cargar más alojamientos usando paginación
  Future<List<AlojamientoTuristico>> fetchMoreAlojamientos(DocumentSnapshot? lastDocument) async {
    Query query = firestore.collection('alojamientosTuristicos').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return AlojamientoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc.id, doc);
    }).toList();
  }
}
