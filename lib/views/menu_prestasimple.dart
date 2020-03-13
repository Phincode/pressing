import 'package:flutter/material.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/espace_client_demande.dart';
import 'package:pressing/views/list_packs.dart';
import 'package:pressing/views/list_souscription.dart';
import 'package:pressing/views/mes_demandes.dart';

import 'login.dart';

class menu_presta extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _menu_presta();
  }

}

class _menu_presta extends State<menu_presta>{
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
                        StoredData().then((d){
                          if(d!=null){
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new espace_client(d);
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
                          Text("Mes demandes"),
                          new Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                            child: new Center(
                              child: new Icon(Icons.content_copy,size: 40,),
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
                              return new Prestation_demande(d);
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
                          Text("Nouvelle demande"),
                          new Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                            child: new Center(
                              child: new Icon(Icons.add_box,size: 40,),
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