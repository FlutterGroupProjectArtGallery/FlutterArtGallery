import 'package:flutter/material.dart';

class MyHouseDrawer extends StatelessWidget {
  const MyHouseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      appBar: AppBar(
        title: const Text('Drawer and List Application'),
      ),
      body: const Center(
        child: Text('Home Stuff',
            style: TextStyle(fontSize: 50, color: Colors.white)),
      ),
    );
  }
}
