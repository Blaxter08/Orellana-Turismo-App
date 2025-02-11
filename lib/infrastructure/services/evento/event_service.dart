import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/evento/evento_model.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Colección de eventos
  CollectionReference get _eventCollection => _firestore.collection('events');

  // Obtener todos los eventos en tiempo real
  Stream<List<Event>> getEventsStream() {
    return _eventCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Crear un evento
  Future<void> createEvent(Event event) async {
    await _eventCollection.doc(event.id).set(event.toMap());
  }

  // Actualizar un evento
  Future<void> updateEvent(String id, Event event) async {
    await _eventCollection.doc(id).update(event.toMap());
  }

  // Eliminar un evento
  Future<void> deleteEvent(String id) async {
    await _eventCollection.doc(id).delete();
  }
}
