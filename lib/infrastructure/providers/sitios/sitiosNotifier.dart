import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/infrastructure/providers/sitios/sitios_firestore.dart';

import '../../../domain/entities/sitios.dart';

final sitiosProvider = StateNotifierProvider<SitiosNotifier, List<Sitio>>((ref) => SitiosNotifier());

class SitiosNotifier extends StateNotifier<List<Sitio>> {
  final FirestoreService _firestoreService = FirestoreService();
  final List<String> categorias = ['Hoteles', 'Hostales', 'Hosterias-Lodges'];
  int currentPage = 1;
  bool isLoading = false;

  SitiosNotifier() : super([]);

  Future<void> loadSites() async {
    if (isLoading) return;
    isLoading = true;

    final newSites = await _firestoreService.getSitesByCategories(categorias, page: currentPage);
    state = [...state, ...newSites];
    currentPage++;

    isLoading = false;
  }
}
