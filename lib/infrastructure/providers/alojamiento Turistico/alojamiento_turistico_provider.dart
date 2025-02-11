import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/alojamientos turisticos/alojamientos_turisiticos_entidad.dart';
import '../../services/alojamiento Turistico/alojamiento_turistico_service.dart';

final alojamientoTuristicoServiceProvider = Provider((ref) => AlojamientoTuristicoService());

class AlojamientosTuristicosNotifier extends StateNotifier<AsyncValue<List<AlojamientoTuristico>>> {
  AlojamientosTuristicosNotifier(this._service) : super(const AsyncValue.loading()) {
    _subscribeToAlojamientos();
  }

  final AlojamientoTuristicoService _service;
  List<AlojamientoTuristico> _currentAlojamientos = [];
  DocumentSnapshot? _lastDocument;
  bool _isFetching = false;

  void _subscribeToAlojamientos() {
    _service.fetchAlojamientosTuristicos().listen(
          (alojamientos) {
        _currentAlojamientos = alojamientos;
        state = AsyncValue.data(_currentAlojamientos);
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error('Error al cargar los alojamientos turísticos: $error', stackTrace);
      },
    );
  }

  Future<void> cargarMasAlojamientos() async {
    if (_isFetching) return; // Evitar múltiples solicitudes simultáneas
    _isFetching = true;

    try {
      // Fetch more alojamientos con paginación
      final result = await _service.fetchMoreAlojamientos(_lastDocument);
      if (result.isNotEmpty) {
        _lastDocument = result.last['documentSnapshot']; // Guardar el último DocumentSnapshot
        final nuevosAlojamientos = result.map((e) => e['data'] as AlojamientoTuristico).toList();
        _currentAlojamientos.addAll(nuevosAlojamientos);
        state = AsyncValue.data(_currentAlojamientos);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('Error al cargar más alojamientos turísticos: $error', stackTrace);
    } finally {
      _isFetching = false;
    }
  }
}

final alojamientosTuristicosProvider = StateNotifierProvider<AlojamientosTuristicosNotifier, AsyncValue<List<AlojamientoTuristico>>>((ref) {
  final service = ref.read(alojamientoTuristicoServiceProvider);
  return AlojamientosTuristicosNotifier(service);
});
