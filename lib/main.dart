import 'package:flutter/material.dart';
import 'package:art_gallery_application/screens/drawer/airplanedrawer.dart';
import 'package:art_gallery_application/screens/drawer/briefcasedrawer.dart';
import 'package:art_gallery_application/screens/drawer/housedrawer.dart';
import 'package:art_gallery_application/screens/homepage.dart';
import 'package:art_gallery_application/userauth/userauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/homepage': (context) => const MyHomePage(),
        '/housedrawer': (context) => const MyHouseDrawer(),
        '/briefcasedrawer': (context) => const MyBriefcaseDrawer(),
        '/airplanedrawer': (context) => const MyAirplaneDrawer(),
      },
      title: 'Pocket Sights Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
