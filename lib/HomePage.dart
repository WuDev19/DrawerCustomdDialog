import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Scaffold.of(context).openDrawer(); //mở drawer
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
        child: Text("Click me", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
