import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/establecimientos.dart';

class EstablishmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Establishment>> getEstablishmentsByCategory(String category) {
    return _firestore
        .collection('establecimientos')
        .where('categoriaPrincipal', isEqualTo: category)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Establishment.fromMap(doc.id, doc.data() as Map<String, dynamic>, doc);
      }).toList();
    });
  }
}
