// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:turismo_app/presentation/providers/sitios/sitios_repositories_provider.dart';
//
// import '../../../domain/entities/sitios.dart';
//
// final nowSitiosProvider = StateNotifierProvider<SitiosNotifier, List<Sitios>>((ref) {
//
//       final fetchMoreSitios = ref.watch(SitiosRepostoryProvider).getNowAventure;
//   return SitiosNotifier(
//       fetchMoreSitios:fetchMoreSitios,
//
//   );
// });
//
// typedef Sitiocallaback = Future<List<Sitios>> Function({int page});
//
// class SitiosNotifier extends StateNotifier<List<Sitios>> {
//   int cuurentpage = 0;
//   Sitiocallaback fetchMoreSitios;
//
//   SitiosNotifier({required this.fetchMoreSitios}) : super([]);
//
//   Future<void> loadNetxPage() async {
//     cuurentpage++;
//     final List<Sitios> sitios = await fetchMoreSitios(page : cuurentpage);
//     state = [...state, ...sitios];
//   }
// }
