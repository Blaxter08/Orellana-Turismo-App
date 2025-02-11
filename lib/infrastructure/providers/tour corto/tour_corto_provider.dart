import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/tour corto/tour_corto.dart';
import '../../services/tour corto/tour_corto_service.dart';

// Proveedor del servicio TourCorto
final tourCortoServiceProvider = Provider<TourCortoService>((ref) => TourCortoService());

// Proveedor de Stream para obtener todos los Tours Cortos en tiempo real
final toursCortosProvider = StreamProvider<List<TourCorto>>((ref) {
  final service = ref.watch(tourCortoServiceProvider);
  return service.getAllToursCortos();
});

// Proveedor de acciones (CRUD) para los Tours Cortos
final tourCortoActionProvider = Provider((ref) => TourCortoActionNotifier(ref));

class TourCortoActionNotifier {
  final Ref _ref;

  TourCortoActionNotifier(this._ref);

  // Crear un nuevo Tour Corto
  Future<void> createTourCorto(TourCorto tourCorto) async {
    await _ref.read(tourCortoServiceProvider).createTourCorto(tourCorto);
  }

  // Actualizar un Tour Corto existente
  Future<void> updateTourCorto(String id, TourCorto tourCorto) async {
    await _ref.read(tourCortoServiceProvider).updateTourCorto(id, tourCorto);
  }

  // Eliminar un Tour Corto
  Future<void> deleteTourCorto(String id) async {
    await _ref.read(tourCortoServiceProvider).deleteTourCorto(id);
  }
}
