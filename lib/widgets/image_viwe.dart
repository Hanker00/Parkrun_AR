import 'package:flutter/material.dart';

class MyImagePage extends StatelessWidget {
  final String imagePath;

  const MyImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: Hero(
          tag: imagePath,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imagePath,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}
