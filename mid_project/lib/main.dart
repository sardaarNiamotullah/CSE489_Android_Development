import 'package:flutter/material.dart';
import 'map_screen.dart';  // Import the map_screen.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mid Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(), // Use MapScreen as the home screen
    );
  }
}