import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPage extends StatefulWidget {
  final String artName;
  final String artistName;
  final String description;
  final String imagePath;

  const ViewPage({
    super.key,
    required this.artName,
    required this.artistName,
    required this.description,
    required this.imagePath,
  });

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isFavorited = false; // Track favorite status

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final querySnapshot = await bookmarkRef.where('name', isEqualTo: widget.artName).get();

      setState(() {
        _isFavorited = querySnapshot.docs.isNotEmpty;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final user = _auth.currentUser;
    if (user != null) {
      final bookmarkRef = _firestore.collection('users').doc(user.uid).collection('likes');
      final itemName = widget.artName;
      final imagePath = widget.imagePath;
      final description = widget.description;

      if (_isFavorited) {
        // Remove from favorites
        final querySnapshot = await bookmarkRef.where('name', isEqualTo: itemName).get();
        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.delete();
        }
      } else {
        // Add to favorites
        await bookmarkRef.add({
          'name': itemName,
          'artist': widget.artistName,
          'imagePath': imagePath,
          'description': description,
        });
      }

      setState(() {
        _isFavorited = !_isFavorited;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.artName,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF333333),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.artName,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorited ? Colors.red : Colors.black,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
              Text(
                widget.artistName,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
