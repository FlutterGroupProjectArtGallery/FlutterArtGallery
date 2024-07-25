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
  List<Map<String, dynamic>> _favoritedItems = []; // List to hold favorited items

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.get();

      // Extract favorited items from Firestore
      final likedItems = querySnapshot.docs.map((doc) {
        final artName = doc.data()['name'] as String;
        final artistName = doc.data()['artist'] as String;
        final imagePath = doc.data()['imagePath'] as String; // Retrieve the imagePath from Firestore
        final description = doc.data()['description'] as String? ?? 'Description for $artName'; // Adjust if needed
        return {
          'artName': artName,
          'artistName': artistName,
          'imagePath': imagePath,
          'description': description,
          'isFavorited': true, // Add this to track the favorite status
          'docId': doc.id, // Add document ID to reference in Firestore
        };
      }).toList();

      setState(() {
        _favoritedItems = likedItems;
      });
    }
  }

  void _onArtworkTap(Map<String, dynamic> artwork) {
    final artName = artwork['artName'] ?? 'Unknown';
    final artistName = artwork['artistName'] ?? 'Unknown';
    final description = artwork['description'] ?? 'No description available'; // Extract description
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
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = item['artName'] as String?;
      final docId = item['docId'] as String?;

      if (itemName == null || docId == null) {
        print("Item name or docId is null");
        return;
      }

      // Update local state immediately
      setState(() {
        _favoritedItems.removeAt(index); // Remove item from local list
      });

      if (item['isFavorited'] == true) {
        // Remove from Firestore
        await bookmarkRef.doc(docId).delete();
      } else {
        // Add to favorites
        await bookmarkRef.add({
          'name': itemName,
          'artist': item['artistName'],
          'imagePath': item['imagePath'],
          'description': item['description'], // Include description if available
        });
      }
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
                  const SizedBox(height: 8), // Add space between title and GridView
                  Expanded(
                    child: GridView.builder(
                      itemCount: _favoritedItems.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final item = _favoritedItems[index];
                        return GestureDetector(
                          onTap: () => _onArtworkTap(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity, // Use available width
                                height: 150, // Set height
                                decoration: BoxDecoration(
                                  color: const Color(0xFF333333),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['imagePath'] ?? '', // Use the stored imagePath
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 80,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4, // Reduced vertical space between image and text
                              ),
                              Container(
                                width: double.infinity, // Use available width
                                padding: const EdgeInsets.all(4.0), // Reduced padding
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['artName'] ?? '', // Display the art name
                                      style: GoogleFonts.poppins(
                                        fontSize: 14, // Reduced font size
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                    Text(
                                      item['artistName'] ?? '', // Display the artist name
                                      style: GoogleFonts.poppins(
                                        fontSize: 12, // Reduced font size
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: item['isFavorited'] ? Colors.red : const Color(0xFF333333),
                                  size: 30, // Reduced icon size
                                ),
                                onPressed: () {
                                  _toggleFavorite(item, index);
                                },
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
