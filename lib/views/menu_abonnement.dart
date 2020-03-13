import 'package:flutter/material.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/list_packs.dart';
import 'package:pressing/views/list_souscription.dart';

import 'login.dart';

class menu_abonnement extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _menu_abonnement();
  }

}

class _menu_abonnement extends State<menu_abonnement>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Orange),
          ),

          ListView(
            children: <Widget>[

              SizedBox(height: 40,),
              new Text("Que Vous voulez-vous faire ?",textAlign: TextAlign.center,textScaleFactor: 2,),
              SizedBox(height: MediaQuery.of(context).size.height/3.7,),
              Center(
                child: Wrap(
                  children: <Widget>[
                   GestureDetector(
                     onTap: (){
                       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                         return new list_packs();
                       }));
                     },
                     child:  Column(
                       children: <Widget>[
                         Text("Voir les packs"),
                         new Container(
                           height: 100,
                           width: 100,
                           decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                           child: new Center(
                             child: new Icon(Icons.book,size: 40,),
                           ),
                         ),

                       ],
                     ),
                   ),
                    SizedBox(width: 10,),
                   GestureDetector(
                     onTap: (){
                       StoredData().then((d){
                         if(d!=null){
                           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                             return new mes_abonnement(d);
                           }));
                         }else{
                           Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                             return Login(0);
                           }));
                         }

                       });

                     },
                     child:  Column(
                       children: <Widget>[
                         Text("Mes souscriptions"),
                         new Container(
                           height: 100,
                           width: 100,
                           decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                           child: new Center(
                             child: new Icon(Icons.assignment_ind,size: 40,),
                           ),
                         ),

                       ],
                     ),

                   ),

                  ],
                ),
              ),
            ],
          ),
          Positioned(top: 20,left: 1,
            child: new IconButton(icon: Icon(Icons.close), onPressed: (){
              Navigator.of(context).pop();
            }),

          ),


        ],
      ),
    );
  }

}