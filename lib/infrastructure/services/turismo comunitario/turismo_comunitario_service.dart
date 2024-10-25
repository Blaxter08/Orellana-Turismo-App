import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/turismo comunitario/turismo_comunitario_entidad.dart';

class TurismoComunitarioService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  // Método para escuchar cambios en tiempo real en la colección de turismo comunitario
  Stream<List<TurismoComunitario>> fetchTurismoComunitarioStream() {
    return firestore.collection('turismosComunitarios').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TurismoComunitario.fromJson(doc.data() as Map<String, dynamic>, doc.id, doc);
      }).toList();
    });
  }

  // Método para cargar más elementos de turismo comunitario usando paginación
  Future<List<TurismoComunitario>> fetchMoreTurismoComunitario(DocumentSnapshot? lastDocument) async {
    Query query = firestore.collection('turismosComunitarios').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return TurismoComunitario.fromJson(doc.data() as Map<String, dynamic>, doc.id, doc);
    }).toList();
  }
}
