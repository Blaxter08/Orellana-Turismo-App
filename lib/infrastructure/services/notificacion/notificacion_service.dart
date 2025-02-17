import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificacionesService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> configurarNotificaciones() async {
    // Suscribir al topic "eventos"
    await _messaging.subscribeToTopic("eventos");
    print("✅ Usuario suscrito al topic 'eventos'");

    // Manejar notificaciones cuando la app está en Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Notificación recibida en Foreground: ${message.notification?.title}");

      // Mostrar un diálogo con la notificación
      showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? "Nueva Notificación"),
          content: Text(message.notification?.body ?? "Tienes una nueva alerta."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(_).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    });

    // Manejar notificaciones en Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📲 Notificación abierta desde Background: ${message.notification?.title}");
    });
  }
}

// Clave Global para acceder al contexto de la app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
