import 'package:flutter/material.dart';
import 'package:art_gallery_application/data/data.dart';

class MyPersonalProfileScreen extends StatelessWidget {
  const MyPersonalProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(args.image),
                ),
              ),
            ),
            Text(
              args.name,
              style: const TextStyle(fontSize: 50, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
