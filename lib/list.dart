import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget {
  Color color=Colors.black54;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tracker",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: color,
        ),
       
      ),
    );
  }
}
