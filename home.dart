import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search.dart'; // Import if you need to navigate to SearchPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to the Home tab

  // Example data for trending items
  final List<Map<String, String>> trendingItems = [
    {'Art1': 'Artist 1'},
    {'Art2': 'Artist 2'},
    {'Art3': 'Artist 3'},
    {'Art4': 'Artist 4'},
    // Add more items as needed
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/search');
    } else if (index == 1) {
      // HOME PAGE ITO
    } else if (index == 2) {
      Navigator.pushNamed(context, '/like');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xE8E8E8),
        title: const Text(
          '  POCKET SIGHT',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w900, // Make the text bold
            letterSpacing: 1.0, // Add letter spacing if needed
          ),
        ),
        centerTitle: false, // Left-align the title
        titleSpacing: 0, // Remove spacing from the start
        toolbarHeight: kToolbarHeight, // Set toolbar height to default
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(
            'Gallery',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          SizedBox(
            height: 600, // Increased height for the box
            child: ListView.builder(
              itemCount: trendingItems.length,
              itemBuilder: (context, index) {
                final item = trendingItems[index];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 330, // Set the width for the box
                          height: 310, // Set the height for the box
                          decoration: BoxDecoration(
                            color: const Color(0xFF333333),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image, // Placeholder icon
                              color: Colors.white,
                              size: 100, // Increased icon size
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 330, // Set the width same as the image
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.keys.first, // Display the art name
                                    style: GoogleFonts.poppins(
                                      fontSize: 24, // Increased font size
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                  Text(
                                    item.values
                                        .first, // Display the artist name
                                    style: GoogleFonts.poppins(
                                      fontSize: 16, // Increased font size
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.favorite_border, // Heart icon
                                color: const Color(0xFF333333),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF333333),
        selectedItemColor: const Color(0xFFF7F7F7),
        unselectedItemColor: Color.fromARGB(255, 209, 209, 209),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
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
