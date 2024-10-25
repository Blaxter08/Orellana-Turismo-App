import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/alimentos y bebidas/alimentos_bebidas_entidad.dart';

class AlimentosYBebidasService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  // Método para escuchar cambios en tiempo real en la colección de alimentos y bebidas
  Stream<List<AlimentosYBebidas>> fetchAlimentosYBebidasStream() {
    return firestore.collection('alimentosYBebidas').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return AlimentosYBebidas.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Método para cargar más alimentos usando paginación
  Future<List<AlimentosYBebidas>> fetchMoreAlimentos(DocumentSnapshot? lastDocument) async {
    Query query = firestore.collection('alimentosYBebidas').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return AlimentosYBebidas.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
