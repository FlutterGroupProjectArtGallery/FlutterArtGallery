import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart'; // Import the ViewPage

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  // Example data for liked items
  final List<Map<String, String>> likedItems = [
    {'Art1': 'Artist 1', 'Description': 'Description for Art1'},
    {'Art2': 'Artist 2', 'Description': 'Description for Art2'},
    {'Art3': 'Artist 3', 'Description': 'Description for Art3'},
    {'Art4': 'Artist 4', 'Description': 'Description for Art4'},
    {'Art5': 'Artist 5', 'Description': 'Description for Art5'},
    {'Art6': 'Artist 6', 'Description': 'Description for Art6'},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xE8E8E8),
        title: const Text(
          '  LIKES',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: likedItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 4.0, // Reduced spacing between rows
            childAspectRatio: 0.75, // Adjust aspect ratio as needed
          ),
          itemBuilder: (context, index) {
            final item = likedItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPage(
                      artName: item.keys.first,
                      artistName: item.values.first,
                      description: item['Description'] ?? '',
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150, // Reduced width for the box
                    height: 150, // Reduced height for the box
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image, // Placeholder icon
                        color: Colors.white,
                        size: 80, // Adjusted icon size
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          2), // Reduced vertical space between image and text
                  Container(
                    width: 150, // Set the width same as the image
                    padding: const EdgeInsets.all(4.0), // Reduced padding
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
                                fontSize: 14, // Reduced font size
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            Text(
                              item.values.first, // Display the artist name
                              style: GoogleFonts.poppins(
                                fontSize: 12, // Reduced font size
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.favorite_border, // Heart icon
                          color: const Color(0xFF333333),
                          size: 30, // Reduced icon size
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
