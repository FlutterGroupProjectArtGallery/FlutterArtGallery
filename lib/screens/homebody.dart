// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';
import 'package:art_gallery_application/data/data.dart'; // Ensure this import is correct
import 'dart:convert'; // For encoding/decoding JSON data
import 'package:shared_preferences/shared_preferences.dart'; // For persistent storage

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, List<Map<String, String>>> _artworks = artworkDetails;
  final Map<String, bool> _isFavorited = {}; // Track favorites status
  late AnimationController _animationController;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  List<Map<String, String>> _filteredArtworks = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    _checkAndUpdateArtworks();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef =
          _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.get();
      final likedItems = querySnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
      setState(() {
        _isFavorited.addAll({for (var item in likedItems) item: true});
      });
    }
  }

  Future<void> _checkAndUpdateArtworks() async {
    final prefs = await SharedPreferences.getInstance();
    final isInitialized = prefs.getBool('app_initialized') ?? false;

    if (!isInitialized) {
      await _shuffleArtworks();
      await prefs.setBool('app_initialized', true);
    } else {
      await _loadFilteredArtworks();
    }
  }

  Future<void> _shuffleArtworks() async {
    final allArtworks =
        _artworks.values.expand((artworks) => artworks).toList();
    final filteredArtworks = allArtworks
        .where((item) => !_isFavorited.containsKey(item['Title']))
        .toList();
    filteredArtworks.shuffle();
    final jsonArtworks = jsonEncode(filteredArtworks);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('shuffled_artworks', jsonArtworks);

    setState(() {
      _filteredArtworks = filteredArtworks;
    });
  }

  Future<void> _loadFilteredArtworks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonArtworks = prefs.getString('shuffled_artworks');
    if (jsonArtworks != null) {
      final List<dynamic> decodedArtworks = jsonDecode(jsonArtworks);
      setState(() {
        _filteredArtworks = decodedArtworks.map((item) {
          final Map<String, dynamic> dynamicMap = item as Map<String, dynamic>;
          return Map<String, String>.from(dynamicMap);
        }).toList();
      });
    } else {
      await _shuffleArtworks();
    }
  }

  Future<void> _toggleFavorite(Map<String, String> item) async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef =
          _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = item['Title'] ?? '';
      final imagePath = item['FileLocation'] ?? '';
      final description = item['Description'] ?? '';

      if (itemName.isEmpty) {
        print("Item name is empty.");
        return;
      }

      try {
        if (_isFavorited[itemName] == true) {
          final querySnapshot =
              await bookmarkRef.where('name', isEqualTo: itemName).get();
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

        _animationController
            .forward()
            .then((_) => _animationController.reverse());
      } catch (e) {
        print("Error toggling favorite: $e");
      }
    } else {
      print("No user is logged in.");
    }
  }

  Future<void> _getArtworks(String category) async {
    final allArtworks = _artworks.values.expand((list) => list).toList();
    if (category == 'Trending') {
      _filteredArtworks = allArtworks
          .where((item) => !_isFavorited.containsKey(item['Title']))
          .toList();
      _filteredArtworks.shuffle();
      _filteredArtworks = _filteredArtworks.take(10).toList();
    } else {
      _filteredArtworks = _artworks[category] ?? [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            height: 750, // Adjust height as needed
            child: ListView.builder(
              itemCount: _filteredArtworks.length,
              itemBuilder: (context, index) {
                final item = _filteredArtworks[index];
                final artName = item['Title'] ?? '';
                final artistName = item['Artist'] ?? '';
                final imagePath = item['FileLocation'] ?? '';
                final description = item['Description'] ?? '';

                return GestureDetector(
                  onTap: () {
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
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 330,
                            height: 310,
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
                            width: 330,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        artName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF333333),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        artistName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xFF555555),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isFavorited[artName] == true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _isFavorited[artName] == true
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    _toggleFavorite(item);
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
      ),
    );
  }
}
