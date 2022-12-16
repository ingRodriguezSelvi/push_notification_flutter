//sha1: 65:4E:6C:BA:EE:D9:83:4F:96:70:D6:BA:BE:E7:26:D6:D1:D9:2F:57

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static  final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future<void> _backgroundHandler(RemoteMessage message) async { // APLICACION TERMINADO
    print('onBackgroundHandler: ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future<void> _onMessageHandler(RemoteMessage message) async { // APLICACION EN PRIMER PLANO
    print('onMessageHandler: ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future<void> _onOpenMessageHandler(RemoteMessage message) async { // APLICACION EN SEGUNDO PLANO
    print('onOpenMessageHandler: ${message.data}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future<void> initializeApp() async {

    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    //Hanlgrer
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageHandler);

    // Local Notifications
    print('token: $token');
  }

  static closeStreams() { // CERRAR STREAMS
    _messageStream.close();
  }
}