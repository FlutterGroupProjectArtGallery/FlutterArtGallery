import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart'; // Import the Category class
import 'package:art_gallery_application/data/data.dart'; // Import the data file
import 'view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> _trendingItems = [];
  List<Map<String, String>> _allArtworks = [];
  String? _selectedCategory; // State variable for the selected category
  String _searchQuery = ''; // State variable for the search query

  @override
  void initState() {
    super.initState();
    _loadArtworks(); // Load artworks when the page is loaded
  }

  Future<void> _loadArtworks() async {
    _allArtworks = artworkDetails.values.expand((artworks) => artworks).toList();
    print('All artworks count: ${_allArtworks.length}');
    _updateSearchResults(); // Update the search results based on the initial state
  }

  void _updateSearchResults() {
    setState(() {
      List<Map<String, String>> filteredArtworks = _allArtworks;

      // Filter by category if one is selected
      if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
        final selectedCategoryLower = _selectedCategory!.toLowerCase(); // Convert selected category to lowercase
        filteredArtworks = filteredArtworks.where((artwork) {
          final categories = artwork['Categories']?.split(',') ?? [];
          return categories.any((category) => category.trim().toLowerCase() == selectedCategoryLower);
        }).toList();
      }

      // Filter by search query
      if (_searchQuery.isNotEmpty) {
        filteredArtworks = filteredArtworks.where((artwork) {
          final title = artwork['Title']?.toLowerCase() ?? '';
          return title.contains(_searchQuery.toLowerCase());
        }).toList();
      }

      filteredArtworks.shuffle(); // Shuffle the artworks

      // Limit the number of trending items to 10
      _trendingItems = filteredArtworks.take(10).toList();
      print('Trending items count: ${_trendingItems.length}');
    });
  }

  void _onArtworkTap(Map<String, String> artwork) {
    final artName = artwork['Title'] ?? 'Unknown';
    final artistName = artwork['Artist'] ?? 'Unknown';
    final description = artwork['Description'] ?? 'No description available'; // Extract description
    final imagePath = artwork['FileLocation'] ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPage(
          artName: artName,
          artistName: artistName,
          description: description,
          imagePath: imagePath,
        ),
      ),
    );
  }

  void _onCategoryButtonPressed(String category) {
    setState(() {
      _selectedCategory = category; // Update the selected category
      print('Selected Category: $_selectedCategory'); // Debug print
      _updateSearchResults(); // Refresh the artworks based on the selected category
    });
  }

  @override
  Widget build(BuildContext context) {
    final Category category = Category(); // Create an instance of Category
    final List<String> allCategories = category.getCategoryPairs().expand((pair) => pair).toList();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update search query
                  _updateSearchResults(); // Update search results
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by artwork name',
                hintStyle: const TextStyle(color: Color.fromARGB(160, 51, 51, 51)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF333333)),
                filled: true,
                fillColor: const Color(0xFFE8E8E8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Categories',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set to 2 columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3, // Adjust aspect ratio to fit 2 columns
              ),
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                final categoryName = allCategories[index];

                return ElevatedButton(
                  onPressed: () {
                    print('Button pressed: $categoryName'); // Debug print
                    _onCategoryButtonPressed(categoryName);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40), // Adjust size to make buttons more visible
                    backgroundColor: const Color(0xFF333333), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: Text(
                    categoryName,
                    style: GoogleFonts.poppins(
                      fontSize: 16, // Increase font size
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEDEDED),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              _selectedCategory ?? 'Trending',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          SizedBox(
            height: 300, // Adjust height as needed
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _trendingItems.map((item) {
                  final artName = item['Title'] ?? 'Unknown';
                  final artistName = item['Artist'] ?? 'Unknown';
                  final imagePath = item['FileLocation'] ?? '';

                  return GestureDetector(
                    onTap: () => _onArtworkTap(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 150, // Adjust width as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                          children: [
                            Container(
                              width: 150, // Match container width to the overall width
                              height: 150, // Adjust height as needed
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
                                    return const Center(
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
                            const SizedBox(height: 8),
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
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
