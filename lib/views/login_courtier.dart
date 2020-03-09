import 'package:flutter/material.dart';
import 'package:pressing/style/style.dart';

class LoginC extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginC();
  }

}

class _LoginC extends State<LoginC>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: new Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 0.0,
              child: new Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/3,
              right: 0.0,
              child: new Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/1.1,
              right: 0.0,
              child: new Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.deepPurple),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/1.1,
              left: 0.0,
              child: new Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.indigo),
              ),
            ),
            ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                new Center(
                  child: Container(
                    width:100,
                    height: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle,color: Orange),
                    child: new Center(child: new Text("MP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2,),),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                new Card(
                  elevation: 4,
                  child:Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: Form(
                      child: ListView(
                        children: <Widget>[
                          Center(child: Text("Connexion Courtier",textAlign: TextAlign.center,textScaleFactor: 1.3,),),
                          SizedBox(height: 50,),
                          new TextFormField(
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Téléphone"),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 20,),
                          new TextFormField(
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Password"),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10,),
                          new Center(
                            child: Container(
                              width:60,
                              height: 60,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Orange),
                              child: new Center(child:new Icon(Icons.navigate_next,color: Colors.white,size: 50,),),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ) ,
                ),



              ],
            ),

          ],
        ),
      ),
    );
  }

}