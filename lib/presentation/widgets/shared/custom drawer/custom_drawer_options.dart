import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawerOptions extends StatelessWidget {
  const CustomDrawerOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text('Mi cuenta'),
          onTap: () => context.push('/editar-cuenta'), // Cambiado a push
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Guía Turística'),
          onTap: () => context.push('/guide'), // Cambiado a push
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Ayuda'),
          onTap: () => context.push('/ayuda'), // Cambiado a push
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Configuraciones'),
          onTap: () => context.push('/ajustes'), // Cambiado a push
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text('Política de Privacidad'),
          onTap: () => context.push('/privacy'), // Cambiado a push
        ),
      ],
    );
  }
}
