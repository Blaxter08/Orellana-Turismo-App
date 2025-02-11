import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/infrastructure/providers/userFireService/user_info_service.dart';

// Instancia del servicio
final userServiceProvider = Provider((ref) => UserService());

// Provider para obtener datos del usuario desde Firestore
final userProvider = FutureProvider<DocumentSnapshot?>((ref) async {
  final userService = ref.read(userServiceProvider);
  return userService.getUserData();
});
