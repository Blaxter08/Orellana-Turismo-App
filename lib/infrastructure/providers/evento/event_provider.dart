import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/evento/evento_model.dart';
import '../../services/evento/event_service.dart';

// Proveedor del servicio de eventos
final eventServiceProvider = Provider<EventService>((ref) {
  return EventService();
});

// Proveedor del Stream de eventos
// Proveedor del Stream de eventos activos
final eventosProvider = StreamProvider<List<Event>>((ref) {
  final eventService = ref.watch(eventServiceProvider);

  // Filtra los eventos para incluir solo los activos
  return eventService.getEventsStream().map(
        (eventos) => eventos.where((event) => event.isActive).toList(),
  );
});


// Proveedor para acciones de eventos (crear, actualizar, eliminar)
final eventActionsProvider = Provider((ref) {
  final eventService = ref.watch(eventServiceProvider);
  return EventActions(eventService);
});

// Clase para manejar acciones
class EventActions {
  final EventService _eventService;

  EventActions(this._eventService);

  Future<void> createEvent(Event event) async {
    await _eventService.createEvent(event);
  }

  Future<void> updateEvent(String id, Event event) async {
    await _eventService.updateEvent(id, event);
  }

  Future<void> deleteEvent(String id) async {
    await _eventService.deleteEvent(id);
  }
}
