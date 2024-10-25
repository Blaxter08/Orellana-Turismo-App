// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:turismo_app/infrastructure/providers/establecimientos/establishment_service.dart';
// import 'package:turismo_app/domain/entities/establecimientos.dart';
//
// final establecimientosProvider = StateNotifierProvider<EstablecimientosNotifier, List<Establishment>>((ref) => EstablecimientosNotifier());
//
// class EstablecimientosNotifier extends StateNotifier<List<Establishment>> {
//   final EstablishmentService _establishmentService = EstablishmentService();
//   final List<String> categorias = ['Hospedaje'];
//   int currentPage = 1;
//   bool isLoading = false;
//
//   EstablecimientosNotifier() : super([]);
//
//   Future<void> loadEstablishments() async {
//     if (isLoading) return;
//     isLoading = true;
//
//     final newEstablishments = await _establishmentService.getEstablishmentsByCategories(categorias, page: currentPage);
//     state = [...state, ...newEstablishments];
//     currentPage++;
//
//     isLoading = false;
//   }
// }
