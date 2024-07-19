import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  final String text;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(255, 121, 120, 120),
        child: ListTile(
          title: Text(text),
          textColor: Colors.white,
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ));
  }
}
