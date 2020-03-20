import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/checking.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/admin_home.dart';
import 'package:pressing/views/inscription.dart';
import 'package:pressing/views/menu_prestasimple.dart';
import 'package:pressing/functions/calling.dart';
import 'package:pressing/views/tarif.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'espace_courtier.dart';
import 'login.dart';
import 'login_courtier.dart';
import 'menu_abonnement.dart';


class Accueil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Accueil();
  }


}

class _Accueil extends State<Accueil>{
  int slideIndex=0;
  bool isclickMenu=false;
  var ico=Icon(Icons.dehaze);

  bool voiplus=false;

  final scroocontroller=ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Orange,
          title: new Text("Accueil",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: <Widget>[
            new Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("assets/images/logo2.png"),fit: BoxFit.cover)),
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
            child:Stack(
              children: <Widget>[
                DraggableScrollbar.semicircle(
                  controller: scroocontroller,

                  child:ListView(
                    controller: scroocontroller,
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
                        child: new Text("Nos Services",textAlign: TextAlign.center,style: TextStyle(color: Orange), textScaleFactor: 1.3,),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width,
                        child:  ListView.builder(itemCount:data.length,itemBuilder: (BuildContext context,index){
                          return new Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10,left: 6,right: 6),
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data[index]["image"]),fit: BoxFit.cover)),
                            child: new Center(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(" "+data[index]["titre"]),
                                      SizedBox(height: 5,),
                                      GestureDetector(
                                        onTap: (){
                                          launchURL("tel:"+data[index]["numero"].toString());
                                        },
                                        child: new Container(
                                          height: 20,
                                          width: 100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                          child: new Center(child: new Text("Appeler",style: TextStyle(color: Colors.white),),),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      voiplus?Container(
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width,
                          child: StreamBuilder(
                            stream: Firestore.instance.collection("services").snapshots(),
                            builder: (BuildContext context , snapshot){
                              if(snapshot.hasData){
                                return ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (BuildContext context,index){
                                  return new Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    margin: EdgeInsets.only(bottom: 10,left: 6,right: 6),
                                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image"]),fit: BoxFit.cover)),
                                    child: new Center(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Text(" "+snapshot.data.documents[index]["titre"]),
                                              SizedBox(height: 5,),
                                              GestureDetector(
                                                onTap: (){
                                                  launchURL("tel:"+snapshot.data.documents[index]["numero"].toString());
                                                },
                                                child: new Container(
                                                  height: 20,
                                                  width: 100,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                                  child: new Center(child: new Text("Appeler",style: TextStyle(color: Colors.white),),),
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                                    return new tarif(snapshot.data.documents[index]);
                                                  }));
                                                },

                                                child: new Container(
                                                  height: 20,
                                                  width: 100,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                                  child: new Center(child: new Text("Voir les Tarifs",style: TextStyle(color: Colors.white),),),
                                                ),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  );
                                });

                              }
                              return new Text("wait...");
                            },
                          )
                      ):GestureDetector(
                        onTap: (){
                          setState(() {
                            voiplus=true;
                          });
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Orange),
                          child: new Center(child: new Text("Voir plus..."),),

                        ),
                      ),
                    ],


                  ),
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
                                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                                  return new Admin();
                                }));
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
            )





        ));
  }

}