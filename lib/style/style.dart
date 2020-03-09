import 'package:flutter/material.dart';

var Orange= Color(0xFFff6d00);

List<Container> image=[
  Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/carrousel1.jpg"),fit: BoxFit.cover)),
  ),
  Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/carrousel2.jpg"),fit: BoxFit.cover)),
  ),
  Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/carrousel1.jpg"),fit: BoxFit.cover)),
  ),
  Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/carrousel2.jpg"),fit: BoxFit.cover)),
  ),
];

List <Map>menu=[
  {
    "titre":"Accueil",
    "icon":Icons.home,
  },
  {
    "titre":"Inscription",
    "icon":Icons.queue,

  },
  {
    "titre":"Connexion",
    "icon":Icons.phonelink_setup,
  },
  {
    "titre":"Abonnement",
    "icon":Icons.class_,
  },
  {
    "titre":"Courtier",
    "icon":Icons.directions_run,
  },
  {
    "titre":"Prestation Simple",
    "icon":Icons.wc,
  }
];