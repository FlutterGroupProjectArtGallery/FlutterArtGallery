import 'package:flutter/material.dart';
import 'package:art_gallery_application/screens/drawer/airplanedrawer.dart';
import 'package:art_gallery_application/screens/drawer/briefcasedrawer.dart';
import 'package:art_gallery_application/screens/drawer/housedrawer.dart';
import 'package:art_gallery_application/screens/homepage.dart';
import 'package:art_gallery_application/screens/profile.dart';

void main() {
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
        '/second': (context) => const MyPersonalProfileScreen(),
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
