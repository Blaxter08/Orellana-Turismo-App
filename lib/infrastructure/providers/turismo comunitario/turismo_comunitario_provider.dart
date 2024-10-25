import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/turismo comunitario/turismo_comunitario_entidad.dart';
import '../../services/turismo comunitario/turismo_comunitario_service.dart';

class TurismoComunitarioNotifier extends StateNotifier<AsyncValue<List<TurismoComunitario>>> {
  final TurismoComunitarioService _service;
  List<TurismoComunitario> _currentTurismos = [];
  DocumentSnapshot? _lastDocument; // Referencia al último documento cargado
  bool _isFetching = false; // Estado para evitar múltiples cargas simultáneas

  TurismoComunitarioNotifier(this._service) : super(const AsyncValue.loading()) {
    _fetchInitialTurismos();
  }

  Future<void> _fetchInitialTurismos() async {
    try {
      state = const AsyncValue.loading();
      final turismos = await _service.fetchMoreTurismoComunitario(null);
      if (turismos.isNotEmpty) {
        _lastDocument = turismos.last.documentSnapshot;
        _currentTurismos = turismos;
        state = AsyncValue.data(_currentTurismos);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> cargarMasTurismos() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final nuevosTurismos = await _service.fetchMoreTurismoComunitario(_lastDocument);
      if (nuevosTurismos.isNotEmpty) {
        _lastDocument = nuevosTurismos.last.documentSnapshot;
        _currentTurismos.addAll(nuevosTurismos);
        state = AsyncValue.data(_currentTurismos);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isFetching = false;
    }
  }
}

// Definición del provider
final turismoComunitarioProvider = StateNotifierProvider<TurismoComunitarioNotifier, AsyncValue<List<TurismoComunitario>>>(
      (ref) => TurismoComunitarioNotifier(TurismoComunitarioService()),
);
