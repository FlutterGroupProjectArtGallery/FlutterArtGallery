import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketSight',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 1;
   // Default to Home
@override
void initState() {
 super.initState();
 FirebaseAuth.instance.authStateChanges().listen((User? user) {
   if (user == null) {
     Navigator.pushNamed(context, '/login');
   } else {
     print("User is signed in!");
     // Update the UI or redirect as needed
   }
 });
} 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: const Text(
          '  POCKET SIGHTS',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontWeight: FontWeight.w900, // Make the text bold
            letterSpacing: 1.0, // Add letter spacing if needed
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false, // Left-align the title
        titleSpacing: 0, // Remove spacing from the start
        toolbarHeight: kToolbarHeight, // Set toolbar height to default
        actions: const [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Material(
                shape: CircleBorder(side: BorderSide(color: Colors.black,width: 2)),
              )),
          Material(
            elevation: 4.0,
            shape: CircleBorder(),
            color: Colors.white,
            child: Icon(Icons.person),
          ),
        ],
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