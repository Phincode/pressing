import 'package:flutter/material.dart';
import 'package:pressing/views/Accueil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mavi Pressing',
      theme: ThemeData(
        fontFamily: "Avenir",
        primarySwatch: Colors.orange,
      ),
      home: Accueil(),
    );
  }
}