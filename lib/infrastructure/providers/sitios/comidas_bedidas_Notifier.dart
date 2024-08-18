import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/domain/entities/sitios.dart';
import 'package:turismo_app/infrastructure/providers/sitios/sitios_firestore.dart';

final comidasBebidasSlideShowProvider = FutureProvider.autoDispose<List<Sitio>>((ref) async {
  final firestoreService = FirestoreService();
  final List<String> categorias = ['Restaurantes', 'Cafeterías', 'Bares & Discotecas'];
  return firestoreService.getSitesByCategories(categorias);
});
