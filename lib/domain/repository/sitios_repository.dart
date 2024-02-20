import 'package:turismo_app/domain/entities/sitios.dart';

abstract class SitiosRepository{
  Future<List<Sitios>>  getNowAventure({int page = 1 });
}