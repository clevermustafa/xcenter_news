import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcenter_news/presentation/feature/initialize_app/initialize_app_cubit.dart';
import 'package:xcenter_news/presentation/gui/pages/initialization_page.dart';

import 'core/dependency_injection/di.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await configureDependencies();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint('User granted permission: ${settings.authorizationStatus}');
  await messaging.subscribeToTopic("notTest");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<InitializeAppCubit>()..getApiKey(),
      child: MaterialApp(
          title: 'Xcenter News',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: const InitializationPage()),
    );
  }
}