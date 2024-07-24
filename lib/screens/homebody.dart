// lib/home_body.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart'; // Import the ViewPage

// Replace with your actual data
final List<Map<String, String>> trendingItems = [
  {'Art1': 'Artist 1'},
  {'Art2': 'Artist 2'},
  {'Art3': 'Artist 3'},
  {'Art4': 'Artist 4'},
  // Add more items as needed
];

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // Initialize a list to track favorite status
  final List<bool> _isFavorited = List.generate(trendingItems.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Text(
          'Gallery',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(
          height: 800, // Increased height for the box
          child: ListView.builder(
            itemCount: trendingItems.length,
            itemBuilder: (context, index) {
              final item = trendingItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPage(
                        artName: item.keys.first,
                        artistName: item.values.first,
                        description: '', // You might want to add a description field to the data
                      ),
                    ),
                  );
                },
                child: Center(
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
                          child: const Center(
                            child: Icon(
                              Icons.image, // Placeholder icon
                              color: Colors.white,
                              size: 100, // Increased icon size
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 330, // Set the width same as the image
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
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
                                    item.values.first, // Display the artist name
                                    style: GoogleFonts.poppins(
                                      fontSize: 16, // Increased font size
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  _isFavorited[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorited[index]
                                      ? Colors.red
                                      : Color(0xFF333333),
                                  size: 24,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isFavorited[index] = !_isFavorited[index];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
