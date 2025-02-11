import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// 🔹 Inicializar Firebase Messaging y Notificaciones Locales
  static Future<void> initialize() async {
    // Solicitar permisos para recibir notificaciones
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Permisos de notificación: ${settings.authorizationStatus}');

    // Obtener y registrar el token en Firestore
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    if (token != null) {
      await _guardarTokenEnFirestore(token);
    }

    // 🔹 Manejar notificaciones en diferentes estados de la app
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);

    // 🔹 Configurar notificaciones locales (cuando la app está en primer plano)
    _configurarNotificacionesLocales();
  }

  /// 🔹 Guardar Token en Firestore
  static Future<void> _guardarTokenEnFirestore(String token) async {
    await FirebaseFirestore.instance.collection('user_tokens').doc(token).set(
      {'token': token}, SetOptions(merge: true),
    );
    print("✅ Token guardado en Firestore");
  }

  /// 🔹 Manejar notificación cuando la app está en primer plano
  static void _onMessageReceived(RemoteMessage message) {
    print("📩 Notificación en Foreground: ${message.notification?.title}");

    // 🔹 Mostrar una notificación local
    _showLocalNotification(message);
  }

  /// 🔹 Manejar cuando el usuario toca la notificación y abre la app
  static void _onMessageOpened(RemoteMessage message) {
    print("🚀 Notificación tocada: ${message.data}");
    // Aquí puedes hacer que la app navegue a una pantalla específica con message.data['evento_id']
  }

  /// 🔹 Configurar Notificaciones Locales (cuando la app está en Foreground)
  static void _configurarNotificacionesLocales() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _localNotificationsPlugin.initialize(initializationSettings);
  }

  /// 🔹 Mostrar Notificación Local
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('canal_principal', 'Notificaciones',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotificationsPlugin.show(
      0, // ID de la notificación
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }
}
