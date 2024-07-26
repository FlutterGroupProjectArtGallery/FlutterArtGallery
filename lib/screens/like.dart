import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart'; // Import the ViewPage

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _favoritedItems =
      []; // List to hold favorited items
  Map<String, bool> _isFavorited = {}; // Map to keep track of favorited items

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef =
          _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.get();

      // Extract favorited items from Firestore
      final likedItems = querySnapshot.docs.map((doc) {
        final artName = doc.data()['name'] as String;
        final artistName = doc.data()['artist'] as String;
        final imagePath = doc.data()['imagePath'] as String;
        final description =
            doc.data()['description'] as String? ?? 'Description for $artName';
        return {
          'artName': artName,
          'artistName': artistName,
          'imagePath': imagePath,
          'description': description,
          'isFavorited': true,
          'docId': doc.id,
        };
      }).toList();

      // Update the _isFavorited map with proper type casting
      _isFavorited = {
        for (var item in likedItems) item['artName'] as String: true
      };

      setState(() {
        _favoritedItems = likedItems;
      });
    }
  }

  void _onArtworkTap(Map<String, dynamic> artwork) {
    final artName = artwork['artName'] ?? 'Unknown';
    final artistName = artwork['artistName'] ?? 'Unknown';
    final description = artwork['description'] ?? 'No description available';
    final imagePath = artwork['imagePath'] ?? '';

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

  Future<void> _toggleFavorite(Map<String, dynamic> item, int index) async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef =
          _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = item['artName'] ?? '';
      final imagePath = item['imagePath'] ?? '';
      final description = item['description'] ?? '';

      if (itemName.isEmpty) {
        print("Item name is empty.");
        return;
      }

      try {
        if (_isFavorited[itemName] == true) {
          // Remove item from Firestore
          final querySnapshot =
              await bookmarkRef.where('name', isEqualTo: itemName).get();
          if (querySnapshot.docs.isNotEmpty) {
            await querySnapshot.docs.first.reference.delete();
          }
        } else {
          // Add item to Firestore
          await bookmarkRef.add({
            'name': itemName,
            'artist': item['artistName'],
            'imagePath': imagePath,
            'description': description,
          });
        }

        // Toggle local favorite state
        setState(() {
          _isFavorited[itemName] = !(_isFavorited[itemName] ?? false);
        });

        // Reload favorites
        _loadFavorites();
      } catch (e) {
        print("Error toggling favorite: $e");
      }
    } else {
      print("No user is logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _favoritedItems.isEmpty
            ? Center(
                child: Text(
                  'No Liked Artworks',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Likes',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _favoritedItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 0.65, // Adjusted from 0.75 to 0.65
                      ),
                      itemBuilder: (context, index) {
                        final item = _favoritedItems[index];
                        return GestureDetector(
                          onTap: () => _onArtworkTap(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF333333),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['imagePath'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 70,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item['artName'] ?? '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF333333),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: item['isFavorited']
                                                ? Colors.red
                                                : const Color(0xFF333333),
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            _toggleFavorite(item, index);
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      item['artistName'] ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF333333),
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                ],
              ),
      ),
    );
  }
}
