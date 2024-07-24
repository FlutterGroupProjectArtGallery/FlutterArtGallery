import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';
import 'package:art_gallery_application/data/data.dart'; // Ensure this import is correct
import 'dart:convert'; // For encoding/decoding JSON data// For shuffling the list
import 'package:shared_preferences/shared_preferences.dart'; // For persistent storage

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, List<Map<String, String>>> _artworks = artworkDetails; // Load data from data.dart

  final Map<String, bool> _isFavorited = {}; // Track favorites status
  late AnimationController _animationController;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  List<Map<String, String>> _filteredArtworks = []; // To hold shuffled artworks

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);

    // Check if the app is being run for the first time or needs reloading
    _checkAndShuffleArtworks();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  Future<void> _checkAndShuffleArtworks() async {
    final prefs = await SharedPreferences.getInstance();
    final isInitialized = prefs.getBool('app_initialized') ?? false;

    if (!isInitialized) {
      // Shuffle artworks upon initialization
      _shuffleArtworks();
      // Store the initialization status
      await prefs.setBool('app_initialized', true);
    } else {
      // Load previously shuffled artworks
      _loadFilteredArtworks();
    }
  }

  Future<void> _shuffleArtworks() async {
  // Combine all categories into a single list
  final allArtworks = _artworks.values.expand((artworks) => artworks).toList();
  print("All artworks combined: ${allArtworks.length} items"); // Debug statement

  final prefs = await SharedPreferences.getInstance();
  final isInitialized = prefs.getBool('app_initialized') ?? false;

  List<Map<String, String>> filteredArtworks;

  if (isInitialized) {
    // If already initialized, no need to filter out liked artworks
    filteredArtworks = allArtworks;
  } else {
    // Filter out liked artworks only on the first shuffle
    filteredArtworks = allArtworks.where((item) => !_isFavorited.containsKey(item['Title'])).toList();
    print("Filtered artworks before shuffle: ${filteredArtworks.length} items"); // Debug statement

    // Store the initialization status
    await prefs.setBool('app_initialized', true);
  }

  // Shuffle the filtered artworks list
  filteredArtworks.shuffle();

  // Encode shuffled artworks to JSON
  final jsonArtworks = jsonEncode(filteredArtworks);
  await prefs.setString('shuffled_artworks', jsonArtworks);

  setState(() {
    _filteredArtworks = filteredArtworks;
    print("Filtered artworks after shuffle: ${_filteredArtworks.length} items"); // Debug statement
  });
}



  Future<void> _loadFilteredArtworks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonArtworks = prefs.getString('shuffled_artworks');
    if (jsonArtworks != null) {
      final List<dynamic> decodedArtworks = jsonDecode(jsonArtworks);
      setState(() {
        // Properly cast decodedArtworks to List<Map<String, String>>
        _filteredArtworks = decodedArtworks.map((item) {
          final Map<String, dynamic> dynamicMap = item as Map<String, dynamic>;
          return Map<String, String>.from(dynamicMap);
        }).toList();
        print("Loaded previously shuffled artworks: ${_filteredArtworks.length} items"); // Debug statement
      });
    } else {
      print("No previously shuffled artworks found.");
      // Optionally shuffle artworks if none found
      _shuffleArtworks();
    }
  }

  Future<void> _toggleFavorite(Map<String, String> item) async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = item['Title'] ?? '';
      final imagePath = item['FileLocation'] ?? '';

      if (itemName.isEmpty) {
        print("Item name is empty.");
        return;
      }

      // Perform the favorite toggle operation
      try {
        if (_isFavorited[itemName] == true) {
          // Remove from favorites
          final querySnapshot = await bookmarkRef.where('name', isEqualTo: itemName).get();
          if (querySnapshot.docs.isNotEmpty) {
            await querySnapshot.docs.first.reference.delete();
          }
        } else {
          // Add to favorites
          await bookmarkRef.add({
            'name': itemName,
            'artist': item['Artist'],
            'imagePath': imagePath,
          });
        }

        // Update local state
        setState(() {
          _isFavorited[itemName] = !(_isFavorited[itemName] ?? false);
        });

        // Play the animation
        _animationController.forward().then((_) => _animationController.reverse());
      } catch (e) {
        print("Error toggling favorite: $e");
      }
    } else {
      print("No user is logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if no artworks are loaded yet
    if (_filteredArtworks.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: ListView(
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
            height: 800, // Adjust height as needed
            child: ListView.builder(
              itemCount: _filteredArtworks.length,
              itemBuilder: (context, index) {
                final item = _filteredArtworks[index];
                final artName = item['Title'] ?? '';
                final artistName = item['Artist'] ?? ''; // Changed 'Creator' to 'Artist'
                final imagePath = item['FileLocation'] ?? '';
                final description = item['Description'] ?? ''; // Ensure the description is available

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPage(
                          artName: artName,
                          artistName: artistName,
                          description: description,
                          imagePath: imagePath, // Pass the imagePath
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
                                      size: 100,
                                    ),
                                  );
                                },
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
                                Flexible(
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
                                        overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                      ),
                                      Text(
                                        artistName, // Display the artist name
                                        style: GoogleFonts.poppins(
                                          fontSize: 16, // Increased font size
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF333333),
                                        ),
                                        overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: _animationDuration,
                                  child: IconButton(
                                    key: ValueKey<bool>(_isFavorited[artName] == true),
                                    icon: Icon(
                                      _isFavorited[artName] == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _isFavorited[artName] == true
                                          ? Colors.red
                                          : const Color(0xFF333333),
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      _toggleFavorite(item);
                                    },
                                  ),
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
      ),
    );
  }
}
