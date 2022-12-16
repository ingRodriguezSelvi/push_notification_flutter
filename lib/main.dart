import 'package:flutter/material.dart';
import 'package:push_notification/screens/screens.dart';
import 'package:push_notification/services/push_notification_service.dart';

void main() async =>{
  WidgetsFlutterBinding.ensureInitialized(),
  await PushNotificationService.initializeApp(),
  runApp(const MyApp())
};

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messageKey = GlobalKey<ScaffoldMessengerState>();


  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      print('Argumento del stream: $message');
      messageKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: messageKey, // Snap
      initialRoute: 'home',
      routes: {
        'home'    : (_) => const HomeScreen(),
        'message' : (_) => const MessageScreen(),
      },
    );
  }
}
