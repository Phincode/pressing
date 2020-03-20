import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/checking.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/gestion_courtier.dart';
import 'package:pressing/views/inscription.dart';
import 'package:pressing/views/menu_prestasimple.dart';
import 'package:pressing/functions/calling.dart';

import 'admin_gestionAbonnement.dart';
import 'admin_gestion_services.dart';
import 'espace_courtier.dart';
import 'login.dart';
import 'login_courtier.dart';
import 'menu_abonnement.dart';


class Admin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Admin();
  }


}

class _Admin extends State<Admin>{
  int slideIndex=0;
  bool isclickMenu=false;
  var ico=Icon(Icons.dehaze);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Orange,
          title: new Text("Espace Admin",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: <Widget>[
            new Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("assets/images/logoAccueil.PNG"),fit: BoxFit.cover)),
            ),
            SizedBox(width: 10,),
          ],
          leading: IconButton(icon:ico ,color: Colors.white,
            onPressed: (){
              setState(() {
                if(!isclickMenu){
                  ico=Icon(Icons.close);
                  isclickMenu=true;
                }else{
                  ico=Icon(Icons.menu);
                  isclickMenu=false;
                }

              });

            },),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance.collection("slidesshows").snapshots(),
                    builder: (BuildContext context,snapshot){
                      if(snapshot.hasData){
                        return CarouselSlider(
                          height: MediaQuery.of(context).size.height/3,
                          viewportFraction: 1.0,
                          aspectRatio: 2.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          enlargeCenterPage: false,
                          items:snapshot.data.documents.map<Widget>((DocumentSnapshot document){
                            return new Builder(
                              builder: (BuildContext context) {
                                return new Stack(
                                  children: <Widget>[
                                    ClipPath(
                                      clipper:OvalBottomBorderClipper() ,
                                      child: Container(
                                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(document["image"]),fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        color:Colors.black38,
                                        child: new Text(document["texte"],style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                      ),
                                    ),

                                  ],
                                );
                              },
                            );

                          }).toList(),
                        );
                      }


                      return new Center(child: Text("loading...",textAlign: TextAlign.center,),);
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  new Center(
                    child: new Text("Choisissez une option",textAlign: TextAlign.center,style: TextStyle(color: Orange), textScaleFactor: 1.3,),
                  ),

                  Container(
                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                    child: new GridView(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),padding: EdgeInsets.all(20),
                         children: <Widget>[
                           GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                 return admin_espace_gestion_services();
                               }));
                             },
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2),
                               decoration: BoxDecoration(color: Orange),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.directions_run,size: 70,color: Colors.white,),
                                     new Text("Gestion des demandes de Service",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),

                           GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                 return Admin_abonnement();
                               }));
                             },
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2),
                               decoration: BoxDecoration(color: Colors.orangeAccent),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.assignment,size: 70,color: Colors.white,),
                                     new Text("Gestion des Abonnements",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                 return Gestion_courtier();
                               }));
                             },
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2,top: 2),
                               decoration: BoxDecoration(color: Colors.orangeAccent),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.person_add,size: 70,color: Colors.white,),
                                     new Text("Ajouter Courtier",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           GestureDetector(
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2,top: 2),
                               decoration: BoxDecoration(color:Orange),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.content_copy,size: 70,color: Colors.white,),
                                     new Text("Gestion des services",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           GestureDetector(
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2,top: 2),
                               decoration: BoxDecoration(color:Orange),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.launch,size: 70,color: Colors.white,),
                                     new Text("Gestion des Slides",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           GestureDetector(
                             child: new Container(
                               width: 50,
                               height: 50,
                               margin: EdgeInsets.only(right: 2,top: 2),
                               decoration: BoxDecoration(color:Colors.orangeAccent),
                               child: new Center(
                                 child: Column(
                                   children: <Widget>[
                                     new Icon(Icons.launch,size: 70,color: Colors.white,),
                                     new Text("Gestion du catalogue de vetement",textAlign: TextAlign.center,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                    ),

                  ),


                ],
              ),

              isclickMenu? Container(
                height: MediaQuery.of(context).size.height/2.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black54),
                child: new GridView.builder(
                    itemCount: 6,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          switch(index){
                            case 0:
                              break;
                            case 1:
                              check_user().then((res){
                                if(!res){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new inscription(0);
                                  }));
                                }
                              });
                              break;
                            case 2:
                              check_user().then((res){
                                if(!res){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new Login(0);
                                  }));
                                }
                              });

                              break;
                            case 3:
                              check_user().then((res){
                                if(!res){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new Login(1);
                                  }));
                                }else{
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new menu_abonnement();
                                  }));
                                }
                              });

                              break;
                            case 4:
                              check_courtier().then((res){
                                if(!res){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new LoginC();
                                  }));
                                }else{
                                  StoredDataC().then((v){
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                                      return new espace_courtier(v);
                                    }));
                                  });

                                }
                              });

                              break;
                            case 5:
                              check_user().then((res){
                                if(!res){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new Login(2);
                                  }));
                                }else{
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new menu_presta();
                                  }));

                                }
                              });

                              break;
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              child: new Center(
                                child: Icon(menu[index]["icon"],color: Orange,),
                              ),
                            ),
                            new Text(menu[index]["titre"],style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      );
                    }),
              ):Text(""),



            ],
          ),

        )

    );
  }

}