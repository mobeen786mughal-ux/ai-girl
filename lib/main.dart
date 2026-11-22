import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('AI Girl 3D'),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.face, size: 120, color: Colors.pink),
              SizedBox(height: 20),
              Text(
                'Hi! Main Tumhari AI Girl Hun!',
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'APK Ban Gaya!',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
