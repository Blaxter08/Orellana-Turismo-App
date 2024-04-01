//
// import 'package:dio/dio.dart';
// import 'package:turismo_app/config/constants/enviroment.dart';
// import 'package:turismo_app/domain/datasource/sitios_data_source.dart';
// import 'package:turismo_app/domain/entities/sitios.dart';
// import 'package:turismo_app/infrastructure/models/sitiosdb/sitiosdbresponse.dart';
//
// class Sitiosdb_Datasource extends SitiosDataSource{
//   final dio = Dio(BaseOptions(
//     baseUrl: 'https://firestore.googleapis.com/v1/projects/turismo-app-efb1d/databases/(default)/documents',
//     queryParameters: {
//       'api_key': Enviroment.SitiosKey,
//       'language':'es-MX'
//     }
//   )
//
//   );
//   @override
//   Future<List<Sitios>> getNowAventure({int page = 1}) async{
//     final response = await dio.get('/sitios');
//     final sitiosdbresponse = SitiosDbResponse.fromMap(response.data);
//     final List<Sitios> sitios = sitiosdbresponse.toMap() as List<Sitios>;
//     print('Hoolaaa $sitios');
//
//     return sitios;
//   }
//
// }