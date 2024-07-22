import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketSight',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: const Text(
          '  POCKET SIGHT',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontWeight: FontWeight.w900, // Make the text bold
            letterSpacing: 1.0, // Add letter spacing if needed
          ),
        ),
        centerTitle: false, // Left-align the title
        titleSpacing: 0, // Remove spacing from the start
        toolbarHeight: kToolbarHeight, // Set toolbar height to default
      ),
      body: Center(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF333333),
        selectedItemColor: const Color(0xFFF7F7F7),
        unselectedItemColor: Color.fromARGB(255, 209, 209, 209),
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
        ],
      ),
    );
  }
}
