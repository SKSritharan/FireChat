import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import './routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fire Chat',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.pages,
    );
  }
}
