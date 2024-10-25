import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/servicios turisiticos/servicios_turisticos_entidad.dart';
import '../../services/servicios Turisticos/servicios_turisticos_services.dart';

class ServiciosTuristicosNotifier extends StateNotifier<AsyncValue<List<ServicioTuristico>>> {
  ServiciosTuristicosNotifier() : super(const AsyncValue.loading()) {
    _fetchInitialServicios();
  }

  final ServicioTuristicoService _service = ServicioTuristicoService();
  List<ServicioTuristico> _currentServicios = [];
  DocumentSnapshot? _lastDocument;
  bool _isFetching = false;

  // Método para cargar la lista inicial de servicios turísticos
  void _fetchInitialServicios() {
    _service.fetchServiciosTuristicos().listen(
          (servicios) {
        _currentServicios = servicios;
        state = AsyncValue.data(_currentServicios);
      },
      onError: (error, stack) {
        state = AsyncValue.error('Error al cargar los servicios turísticos: $error', stack);
      },
    );
  }

  // Método para cargar más servicios turísticos de forma paginada
  Future<void> cargarMasServicios() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final nuevosServicios = await _service.fetchMoreServiciosTuristicos(_lastDocument);
      if (nuevosServicios.isNotEmpty) {
        _lastDocument = nuevosServicios.last.documentSnapshot;
        _currentServicios.addAll(nuevosServicios);
        state = AsyncValue.data(_currentServicios);
      }
    } catch (e, stack) {
      state = AsyncValue.error('Error al cargar más servicios turísticos: $e', stack);
    } finally {
      _isFetching = false;
    }
  }
}

// Definición del provider
final serviciosTuristicosProvider = StateNotifierProvider<ServiciosTuristicosNotifier, AsyncValue<List<ServicioTuristico>>>((ref) {
  return ServiciosTuristicosNotifier();
});
