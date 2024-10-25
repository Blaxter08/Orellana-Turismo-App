import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/alojamientos turisticos/alojamientos_turisiticos_entidad.dart';
import '../../services/alojamiento Turistico/alojamiento_turistico_service.dart';

final alojamientoTuristicoService = AlojamientoTuristicoService();

class AlojamientosTuristicosNotifier extends StateNotifier<AsyncValue<List<AlojamientoTuristico>>> {
  AlojamientosTuristicosNotifier() : super(const AsyncValue.loading()) {
    _subscribeToAlojamientos();
  }

  final AlojamientoTuristicoService _service = alojamientoTuristicoService;
  List<AlojamientoTuristico> _currentAlojamientos = [];
  DocumentSnapshot? _lastDocument;
  bool _isFetching = false;

  void _subscribeToAlojamientos() {
    _service.fetchAlojamientosTuristicos().listen(
          (alojamientos) {
        _currentAlojamientos = alojamientos;
        state = AsyncValue.data(_currentAlojamientos);
      },
      onError: (error, stack) {
        state = AsyncValue.error('Error al cargar los alojamientos turísticos: $error', stack);
      },
    );
  }

  // Método para cargar más alojamientos con paginación
  Future<void> cargarMasAlojamientos() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final nuevosAlojamientos = await _service.fetchMoreAlojamientos(_lastDocument);
      if (nuevosAlojamientos.isNotEmpty) {
        _lastDocument = nuevosAlojamientos.last.documentSnapshot;
        _currentAlojamientos.addAll(nuevosAlojamientos);
        state = AsyncValue.data(_currentAlojamientos);
      }
    } catch (e, stack) {
      state = AsyncValue.error('Error al cargar más alojamientos turísticos: $e', stack);
    } finally {
      _isFetching = false;
    }
  }
}

final alojamientosTuristicosProvider = StateNotifierProvider<AlojamientosTuristicosNotifier, AsyncValue<List<AlojamientoTuristico>>>((ref) {
  return AlojamientosTuristicosNotifier();
});
