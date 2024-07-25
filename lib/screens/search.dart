import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'view.dart';
import 'package:art_gallery_application/data/data.dart'; // Make sure this import is correct

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final Category category = Category();
  List<Map<String, String>> filteredItems = [];
  String _selectedCategory = 'Trending';
  String _searchQuery = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, bool> _isFavorited = {};
  late AnimationController _animationController;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _updateFilteredItems();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _loadFavorites();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _searchAllArtworks(String query) {
    return artworkDetails.values.expand((list) => list).where((item) {
      final title = item['Title']?.toLowerCase() ?? '';
      final artist = item['Artist']?.toLowerCase() ?? '';
      return title.contains(query.toLowerCase()) ||
          artist.contains(query.toLowerCase());
    }).toList();
  }

  Future<void> _loadFavorites() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.get();

      final likedItems = querySnapshot.docs.map((doc) => doc.data()['name'] as String).toList();
      setState(() {
        _isFavorited.addAll(Map.fromIterable(
          likedItems,
          key: (item) => item,
          value: (item) => true,
        ));
      });
    }
  }

  Future<void> _toggleFavorite(Map<String, String> item) async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = item['Title'] ?? '';
      final imagePath = item['FileLocation'] ?? '';
      final description = item['Description'] ?? '';

      if (itemName.isEmpty) {
        print("Item name is empty.");
        return;
      }

      try {
        if (_isFavorited[itemName] == true) {
          final querySnapshot = await bookmarkRef.where('name', isEqualTo: itemName).get();
          if (querySnapshot.docs.isNotEmpty) {
            await querySnapshot.docs.first.reference.delete();
          }
        } else {
          await bookmarkRef.add({
            'name': itemName,
            'artist': item['Artist'],
            'imagePath': imagePath,
            'description': description,
          });
        }

        setState(() {
          _isFavorited[itemName] = !(_isFavorited[itemName] ?? false);
        });

        _animationController.forward().then((_) => _animationController.reverse());
      } catch (e) {
        print("Error toggling favorite: $e");
      }
    } else {
      print("No user is logged in.");
    }
  }

  void _updateFilteredItems() {
    setState(() {
      if (_searchQuery.isNotEmpty) {
        filteredItems = _searchAllArtworks(_searchQuery);
      } else if (_selectedCategory == 'Trending') {
        filteredItems = artworkDetails.values
            .expand((list) => list)
            .toList()
          ..shuffle(Random());
        filteredItems = filteredItems.take(10).toList();
      } else {
        filteredItems = artworkDetails[_selectedCategory] ?? [];
      }
    });
  }

  void _onCategoryButtonPressed(String category) {
    setState(() {
      _selectedCategory = category;
      _updateFilteredItems();
    });
  }

  void _clearCategory() {
    setState(() {
      _selectedCategory = 'Trending';
      _updateFilteredItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> allCategories = category.getCategoryPairs().expand((pair) => pair).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _updateFilteredItems();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Clear Category',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEDEDED),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: allCategories.length,
            itemBuilder: (context, index) {
              final cat = allCategories[index];
              return ElevatedButton(
                onPressed: () => _onCategoryButtonPressed(cat),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedCategory == cat ? Colors.blue : const Color(0xFF333333),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFEDEDED),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            _selectedCategory,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              final artName = item['Title'] ?? 'Unknown';
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPage(
                        artName: artName,
                        artistName: item['Artist'] ?? 'Unknown',
                        description: item['Description'] ?? '',
                        imagePath: item['FileLocation'] ?? '',
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        item['FileLocation'] ?? 'assets/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(item),
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Icon(
                                _isFavorited[artName] == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorited[artName] == true
                                    ? Colors.red
                                    : Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          artName,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
