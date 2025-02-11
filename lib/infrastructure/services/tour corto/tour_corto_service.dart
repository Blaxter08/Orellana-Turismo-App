import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/tour corto/tour_corto.dart';

class TourCortoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Colección de Tours Cortos
  CollectionReference get _toursCortosCollection => _firestore.collection('tours_cortos');

  // Obtener todos los Tours Cortos
  Stream<List<TourCorto>> getAllToursCortos() {
    return _toursCortosCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TourCorto.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Obtener un Tour Corto por ID
  Future<TourCorto?> getTourCortoById(String id) async {
    final doc = await _toursCortosCollection.doc(id).get();
    if (doc.exists) {
      return TourCorto.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Crear un nuevo Tour Corto
  Future<void> createTourCorto(TourCorto tourCorto) async {
    await _toursCortosCollection.add(tourCorto.toMap());
  }

  // Actualizar un Tour Corto existente
  Future<void> updateTourCorto(String id, TourCorto tourCorto) async {
    await _toursCortosCollection.doc(id).update(tourCorto.toMap());
  }

  // Eliminar un Tour Corto
  Future<void> deleteTourCorto(String id) async {
    await _toursCortosCollection.doc(id).delete();
  }
}
