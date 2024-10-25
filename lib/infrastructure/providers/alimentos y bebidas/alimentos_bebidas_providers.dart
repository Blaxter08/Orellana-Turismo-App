import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/alimentos y bebidas/alimentos_bebidas_entidad.dart';
import '../../services/alimetos y bebidas/alimentos_bebidas_service.dart';

class AlimentosYBebidasNotifier extends StateNotifier<AsyncValue<List<AlimentosYBebidas>>> {
  final AlimentosYBebidasService _service;
  List<AlimentosYBebidas> _currentAlimentos = [];
  DocumentSnapshot? _lastDocument; // Referencia al último documento cargado
  bool _isFetching = false; // Estado para evitar múltiples cargas simultáneas

  AlimentosYBebidasNotifier(this._service) : super(const AsyncValue.loading()) {
    _fetchInitialAlimentos();
  }

  Future<void> _fetchInitialAlimentos() async {
    try {
      state = const AsyncValue.loading();
      final alimentos = await _service.fetchMoreAlimentos(null);
      if (alimentos.isNotEmpty) {
        _lastDocument = alimentos.last.documentSnapshot;
        _currentAlimentos = alimentos;
        state = AsyncValue.data(_currentAlimentos);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> cargarMasAlimentos() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final nuevosAlimentos = await _service.fetchMoreAlimentos(_lastDocument);
      if (nuevosAlimentos.isNotEmpty) {
        _lastDocument = nuevosAlimentos.last.documentSnapshot;
        _currentAlimentos.addAll(nuevosAlimentos);
        state = AsyncValue.data(_currentAlimentos);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isFetching = false;
    }
  }
}

// Definición del provider
final alimentosYBebidasProvider = StateNotifierProvider<AlimentosYBebidasNotifier, AsyncValue<List<AlimentosYBebidas>>>(
      (ref) => AlimentosYBebidasNotifier(AlimentosYBebidasService()),
);

