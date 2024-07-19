import 'package:flutter/material.dart';
import 'package:art_gallery_application/data/data.dart';
import 'package:art_gallery_application/widgets/widgets.dart';

class MyBodyHome extends StatefulWidget {
  const MyBodyHome({super.key, required Person person});

  @override
  State<MyBodyHome> createState() => _MyBodyHomeState();
}

class _MyBodyHomeState extends State<MyBodyHome> {
  var person = Person();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            "HELLO",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
          )
        ],
      ),
    );
  }
}
