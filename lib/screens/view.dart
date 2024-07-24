import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPage extends StatelessWidget {
  final String artName;
  final String artistName;
  final String description;

  const ViewPage({
    super.key,
    required this.artName,
    required this.artistName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xE8E8E8),
        title: const Text(
          '  ART DETAIL',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artName, // Display the art name
              style: GoogleFonts.poppins(
                fontSize: 24, // Increased font size
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            SizedBox(height: 8),
            Text(
              artistName, // Display the artist name
              style: GoogleFonts.poppins(
                fontSize: 18, // Increased font size
                fontWeight: FontWeight.normal,
                color: const Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: double.infinity, // Full width
                height: 300, // Adjust height as needed
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.image, // Placeholder icon
                    color: Colors.white,
                    size: 200, // Adjust icon size as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description, // Display the description
                    style: GoogleFonts.poppins(
                      fontSize: 16, // Adjust font size as needed
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF333333),
                    ),
                    textAlign: TextAlign.justify, // Justify text
                  ),
                ),
                SizedBox(width: 16), // Add spacing between description and icon
                Icon(
                  Icons.favorite_border, // Heart icon
                  color: const Color(0xFF333333),
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
