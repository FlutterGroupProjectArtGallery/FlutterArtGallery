import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens.dart'; // Ensure this file contains SearchPage, HomeBody, LikePage

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 1; // Default to the Home tab
  final PageController _pageController = PageController(initialPage: 1);
  
  final List<Widget> _screens = [
    const SearchPage(), // Ensure this widget is correctly defined
    HomeBody(), // Ensure this widget is correctly defined
    const LikePage(), // Ensure this widget is correctly defined
  ];

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      } else {
        print("User is signed in!");
        // Update the UI or redirect as needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0x00e8e8e8),
        title: const Text(
          '  POCKET SIGHTS',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w900, // Make the text bold
            letterSpacing: 1.0, // Add letter spacing if needed
          ),
        ),
        centerTitle: false, // Left-align the title
        titleSpacing: 0, // Remove spacing from the start
        toolbarHeight: kToolbarHeight, // Set toolbar height to default
        automaticallyImplyLeading: false,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Material(
              shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2)),
            ),
          ),
          Material(
            elevation: 4.0,
            shape: const CircleBorder(),
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFF333333),
          indicatorColor: const Color(0xFF333333),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Likes',
            ),
          ],
          onDestinationSelected: _onItemTapped,
          selectedIndex: currentIndex,
        ),
      ),
    );
  }
}
