import 'package:flutter/material.dart';
import 'package:art_gallery_application/data/data.dart';
import 'package:art_gallery_application/screens/screens.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 1;
  int selectedIndex = 1;

  final List<Widget> _screens = [
    const MyAirplaneBody(),
    MyBodyHome(person: Person()),
    const MySettingsBody(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Material(
                shape: CircleBorder(),
              )),
          Material(
            elevation: 4.0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: Icon(Icons.person),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _screens[currentIndex],
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const SizedBox(
              height: 65,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Text("Pocket Sights"),
              ),
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading: const Icon(Icons.home),
              title: const Text("House"),
              trailing: const Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushNamed(context, '/housedrawer');
              },
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading: const Icon(Icons.work),
              title: const Text("Brief Case"),
              trailing: const Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushNamed(context, '/briefcasedrawer');
              },
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading: const Icon(Icons.flight),
              title: const Text("Airplane"),
              trailing: const Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushNamed(context, '/airplanedrawer');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        indicatorColor: const Color.fromARGB(255, 99, 102, 101),
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.flight,
                color: Colors.white,
              ),
              label: 'Category'),
          NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home'),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Settings',
          ),
        ],
        surfaceTintColor: Colors.black,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
      ),
    );
  }
}
