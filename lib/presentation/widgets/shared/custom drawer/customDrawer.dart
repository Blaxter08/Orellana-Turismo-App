import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../infrastructure/providers/userFireService/user_info_provider.dart';
import 'custom_drawer_header.dart';
import 'custom_drawer_options.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSnapshot = ref.watch(userProvider); // Usa el provider para obtener datos del usuario

    return Drawer(
      child: Column(
        children: [
          // Header del Drawer
          userSnapshot.when(
            data: (data) {
              if (data == null) {
                return CustomDrawerHeader(
                  displayName: 'Nombre de Usuario',
                  email: 'usuario@example.com',
                  photoURL: '', // URL vacía si no hay imagen
                );
              }

              final userData = data.data() as Map<String, dynamic>?;
              return CustomDrawerHeader(
                displayName: userData?['displayName'] ?? 'Nombre de Usuario',
                email: userData?['email'] ?? 'usuario@example.com',
                photoURL: userData?['photoUrl'] ?? '',
              );
            },
            loading: () => CustomDrawerHeader.loading(), // Muestra un estado de carga
            error: (error, stack) => CustomDrawerHeader.error(), // Maneja errores
          ),

          // Opciones del Drawer
          Expanded(
            child: CustomDrawerOptions(),
          ),

          // Opción de cerrar sesión
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () async {
              ref.read(userServiceProvider).signOut(); // Usa el servicio para cerrar sesión
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
