import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/alojamientos turisticos/alojamientos_turisiticos_entidad.dart';

class AlojamientoTuristicoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  Stream<List<AlojamientoTuristico>> fetchAlojamientosTuristicos() {
    return _firestore.collection('alojamientosTuristicos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AlojamientoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<List<Map<String, dynamic>>> fetchMoreAlojamientos(DocumentSnapshot? lastDocument) async {
    Query query = _firestore.collection('alojamientosTuristicos').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return {
        'data': AlojamientoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc.id),
        'documentSnapshot': doc,
      };
    }).toList();
  }
}
