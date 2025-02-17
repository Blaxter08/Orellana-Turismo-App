import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacionesService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> inicializarNotificaciones() async {
    // Solicitar permisos
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Permisos de notificación concedidos");
    } else {
      print("⚠️ Permisos de notificación denegados");
      return;
    }

    // Guardar token en Firestore
    String? token = await _messaging.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection("user_tokens").doc(token).set({
        "token": token,
        "fechaRegistro": FieldValue.serverTimestamp(),
      });
      print("📲 Token registrado en Firestore: $token");
    }

    // Suscribir al usuario al topic "eventos"
    await _messaging.subscribeToTopic("eventos");
    print("📩 Usuario suscrito al topic 'eventos'");

    // Escuchar notificaciones en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📨 Notificación recibida: ${message.notification?.title}");
    });
  }
}
