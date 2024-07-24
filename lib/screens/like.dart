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
  List<bool> _isFavorited = [];

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
      
      // Initialize _isFavorited list based on the number of items
      setState(() {
        _isFavorited = List.generate(6, (_) => false); // Adjust the number according to your data length
      });

      final likedItems = querySnapshot.docs.map((doc) => doc.data()['name'] as String).toList();
      for (int i = 0; i < likedItems.length; i++) {
        if (likedItems.contains(likedItems[i])) {
          setState(() {
            _isFavorited[i] = true;
          });
        }
      }
    }
  }

  Future<void> _toggleFavorite(Map<String, String> item, int index) async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.where('name', isEqualTo: item.keys.first).get();
      if (querySnapshot.docs.isEmpty) {
        await bookmarkRef.add({'name': item.keys.first, 'artist': item.values.first});
      } else {
        await querySnapshot.docs.first.reference.delete();
      }
      setState(() {
        _isFavorited[index] = !_isFavorited[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                itemCount: likedItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 0.75,
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
                          child: const Center(
                            child: Icon(
                              Icons.image, // Placeholder icon
                              color: Colors.white,
                              size: 80, // Adjusted icon size
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2, // Reduced vertical space between image and text
                        ),
                        Container(
                          width: 150, // Set the width same as the image
                          padding: const EdgeInsets.all(4.0), // Reduced padding
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
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
                              IconButton(
                                icon: Icon(
                                  _isFavorited[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorited[index]
                                      ? Colors.red
                                      : Color(0xFF333333),
                                  size: 30, // Reduced icon size
                                ),
                                onPressed: () {
                                  _toggleFavorite(item, index);
                                },
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
