import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/atractivos turisticos/atractivos_turisticos_entidad.dart';

class AtractivoTuristicoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  // Este método devuelve un Stream para escuchar cambios en tiempo real
  Stream<List<AtractivoTuristico>> fetchAtractivosTuristicosStream() {
    return firestore.collection('atractivosTuristicos').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return AtractivoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc);
      }).toList();
    });
  }

  // Método para cargar más atractivos usando paginación
  Future<List<AtractivoTuristico>> fetchMoreAtractivos(DocumentSnapshot? lastDocument) async {
    Query query = firestore.collection('atractivosTuristicos').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return AtractivoTuristico.fromJson(doc.data() as Map<String, dynamic>, doc);
    }).toList();
  }
}
