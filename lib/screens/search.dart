import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart'; // Import the Category class
import 'package:art_gallery_application/data/data.dart'; // Import the data file
import 'package:shared_preferences/shared_preferences.dart'; // For persistent storage

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> _trendingItems = [];

  @override
  void initState() {
    super.initState();
    _shuffleArtworks(); // Shuffle artworks every time the page is loaded
  }

  Future<void> _shuffleArtworks() async {
    final allArtworks = artworkDetails.values.expand((artworks) => artworks).toList();
    allArtworks.shuffle(); // Shuffle the artworks

    setState(() {
      _trendingItems = allArtworks; // Update the state with the shuffled artworks
    });
  }

  @override
  Widget build(BuildContext context) {
    final Category category = Category(); // Create an instance of Category

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromARGB(160, 51, 51, 51)),
                prefixIcon: Icon(Icons.search, color: const Color(0xFF333333)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: const Color(0xFF333333)),
                  onPressed: () {
                    // Add filter functionality here
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Filter Options'),
                          content: Text('Add your filter options here.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                filled: true,
                fillColor: const Color(0xFFE8E8E8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Category',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
            itemCount: category.getCategoryPairs().length,
            itemBuilder: (context, index) {
              List<String> pair = category.getCategoryPairs()[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: pair
                      .map((cat) => Expanded(
                            child: Container(
                              width: 60, // Adjust width as needed
                              height: 40, // Adjust height as needed
                              decoration: BoxDecoration(
                                color: const Color(0xFF333333),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 4.0), // Margin around the Container
                              child: Center(
                                child: Text(
                                  cat,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFEDEDED),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Trending',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          SizedBox(
            height: 200, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _trendingItems.length,
              itemBuilder: (context, index) {
                final item = _trendingItems[index];
                final artName = item['Title'] ?? 'Unknown';
                final artistName = item['Artist'] ?? 'Unknown';
                final imagePath = item['FileLocation'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                    children: [
                      Container(
                        width: 120, // Adjust width as needed
                        height: 120, // Adjust height as needed
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333), // Background color for the box
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        artName, // Display the art name
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                        textAlign: TextAlign.left, // Align text to the left
                      ),
                      Text(
                        artistName, // Display the artist name
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF333333),
                        ),
                        textAlign: TextAlign.left, // Align text to the left
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
