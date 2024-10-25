import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/atractivos turisticos/atractivos_turisticos_entidad.dart';
import '../../services/atractivosTuristicos/atractivo_turistico_service.dart';

class AtractivosProvider extends StateNotifier<AsyncValue<List<AtractivoTuristico>>> {
  AtractivosProvider() : super(const AsyncValue.loading()) {
    _fetchInitialAtractivos();
  }

  final AtractivoTuristicoService _service = AtractivoTuristicoService();
  List<AtractivoTuristico> _currentAtractivos = [];
  DocumentSnapshot? _lastDocument; // Referencia al último documento cargado
  bool _isFetching = false; // Estado para evitar múltiples cargas simultáneas

  void _fetchInitialAtractivos() {
    _service.fetchAtractivosTuristicosStream().listen(
          (atractivos) {
        _currentAtractivos = atractivos;
        state = AsyncValue.data(_currentAtractivos);
      },
      onError: (error, stack) {
        state = AsyncValue.error('Error al cargar los atractivos turísticos: $error', stack);
      },
    );
  }

  // Método para cargar más atractivos
  Future<void> cargarMasAtractivos() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final nuevosAtractivos = await _service.fetchMoreAtractivos(_lastDocument);
      if (nuevosAtractivos.isNotEmpty) {
        _lastDocument = nuevosAtractivos.last.documentSnapshot;
        _currentAtractivos.addAll(nuevosAtractivos);
        state = AsyncValue.data(_currentAtractivos);
      }
    } catch (e, stack) {
      state = AsyncValue.error('Error al cargar más atractivos turísticos: $e', stack);
    } finally {
      _isFetching = false;
    }
  }
}

// Definición del provider
final atractivosProvider = StateNotifierProvider<AtractivosProvider, AsyncValue<List<AtractivoTuristico>>>((ref) {
  return AtractivosProvider();
});
