import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart'; // Import the Category class

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Category category = Category(); // Create an instance of Category

  // Example data for trending items
  final List<Map<String, String>> trendingItems = [
    {'Art1': 'Artist 1'},
    {'Art2': 'Artist 2'},
    {'Art3': 'Artist 3'},
    {'Art4': 'Artist 4'},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xE8E8E8),
        title: Text(
          'POCKET SIGHT',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ),
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
            physics:
                NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
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
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      4.0), // Margin around the Container
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
              itemCount: trendingItems.length,
              itemBuilder: (context, index) {
                final item = trendingItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to the left
                    children: [
                      Container(
                        width: 120, // Adjust width as needed
                        height: 120, // Adjust height as needed
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF333333), // Background color for the box
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image, // Placeholder icon
                            color: Colors.white,
                            size: 60, // Adjust icon size as needed
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        item.keys.first, // Display the art name
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                        textAlign: TextAlign.left, // Align text to the left
                      ),
                      Text(
                        item.values.first, // Display the artist name
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
