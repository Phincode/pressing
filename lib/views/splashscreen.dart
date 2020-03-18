
import 'package:flutter/material.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/Accueil.dart';
import 'package:splashscreen/splashscreen.dart';

class splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _splash();
  }


}

class _splash extends State<splash>{
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Accueil(),
      title: new Text('Mavi Pressing',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
      image: new Image.asset("assets/images/logo2.png",),
      gradientBackground: new LinearGradient(colors: [ Orange,  Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("pressing"),
      loaderColor: Orange,
    );
  }

}