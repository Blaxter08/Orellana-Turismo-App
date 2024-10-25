import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/servicios turisiticos/servicios_turisticos_entidad.dart';

class ServicioTuristicoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int _pageSize = 10; // Tamaño del lote de datos a cargar

  // Método para obtener los servicios turísticos en tiempo real desde Firestore
  Stream<List<ServicioTuristico>> fetchServiciosTuristicos() {
    return firestore.collection('serviciosTuristicos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServicioTuristico.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Método para cargar más servicios turísticos usando paginación
  Future<List<ServicioTuristico>> fetchMoreServiciosTuristicos(DocumentSnapshot? lastDocument) async {
    Query query = firestore.collection('serviciosTuristicos').orderBy('nombre').limit(_pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      return ServicioTuristico.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
