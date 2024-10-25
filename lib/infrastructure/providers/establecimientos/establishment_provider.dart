import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/infrastructure/providers/establecimientos/establishment_service.dart';
import 'package:turismo_app/domain/entities/establecimientos.dart';

// Provider para obtener establecimientos de "Hospedaje"
final hospedajeProvider = StreamProvider<List<Establishment>>((ref) {
  final establishmentService = EstablishmentService();
  return establishmentService.getEstablishmentsByCategory('Hospedaje');
});

// Provider para obtener establecimientos de "Alimentación"
final alimentacionProvider = StreamProvider<List<Establishment>>((ref) {
  final establishmentService = EstablishmentService();
  return establishmentService.getEstablishmentsByCategory('Alimentacion');
});

// Provider para obtener establecimientos de "Transporte"
final transporteProvider = StreamProvider<List<Establishment>>((ref) {
  final establishmentService = EstablishmentService();
  return establishmentService.getEstablishmentsByCategory('Transporte');
});

