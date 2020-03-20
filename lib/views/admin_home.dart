import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressing/functions/checking.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/Accueil.dart';
import 'package:pressing/views/gestion_courtier.dart';
import 'package:pressing/views/inscription.dart';
import 'package:pressing/views/menu_prestasimple.dart';
import 'package:pressing/functions/calling.dart';
import 'package:toast/toast.dart';

import 'admin_catalogue_vetement.dart';
import 'admin_gestionAbonnement.dart';
import 'admin_gestion_service_ajout.dart';
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
  final password=TextEditingController();
  var ico=Icon(Icons.dehaze);

  File img;

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
                                    new IconButton(icon:Icon(Icons.delete,size: 50,color: Colors.white),onPressed: () async {
                                           await Firestore.instance.collection("slidesshows").document(document.documentID).delete();
                                           print("ok");
                                    },),
                                   
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
                             onTap: (){
                               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                 return moderation_service();
                               }));
                             },
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
                             onTap: (){
                               more();
                             },
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
                             onTap: (){
                               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                 return new catalogue();
                               }));
                             },
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
                              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                                return new Accueil();
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
          ),

        )

    );
  }
  void more(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            backgroundColor: Colors.orangeAccent,
            title: new Text("Ajout Slide",textAlign: TextAlign.center,),
            content: new Container(
                height: 300,
                width: 300,
                child:new ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    new Divider(height: 10,color: Colors.white,thickness: 2,),
                    new Text("Pour Ajouter un Slide veillez soumettre ces informations:\n"),
                    new Text("Image de préference 200 x 100:\n"),
                    GestureDetector(
                      onTap: () async{
                        await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 200,maxHeight: 112).then((image){
                          if(image!=null){
                            setState(() {
                              img=image;
                            });
                            Navigator.pop(context);
                            more();
                          }
                        });
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle,image:(img==null)?DecorationImage(image: AssetImage("assets/images/services.jpg"),fit: BoxFit.cover): DecorationImage(image: FileImage(img),fit: BoxFit.cover)),
                          child: new Center(
                            child: new Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Titre"),
                      keyboardType: TextInputType.text,
                      controller: password,
                    ),

                  ],
                )
            ),
            actions: <Widget>[
              new RaisedButton(onPressed: (){
                Navigator.pop(context);
              },child: new Text("Fermer"),),
              new RaisedButton(onPressed: () async {
                Toast.show("Traitement en cours...", context,duration: 160);
                if(password.value.text.isNotEmpty && img!=null){
                  StorageReference storageReference = FirebaseStorage().ref();
                  var uploadTask = storageReference
                      .child("sildes")
                      .child(DateTime.now().toString())
                      .putFile(img);
                  var storageSnapshot = await uploadTask.onComplete;
                  var url = await storageSnapshot.ref.getDownloadURL();
                  Firestore.instance.collection("slidesshows").document().setData({
                    'texte':password.value.text,
                    'image':url.toString(),
                    'created':FieldValue.serverTimestamp()
                  }).then((v){
                    Toast.show("ok", context);
                    password.clear();
                    Navigator.pop(context);
                  },onError: (err){
                    Toast.show("$err", context);
                    Navigator.pop(context);
                  });


                }else{
                  Toast.show("Informations insuffisante pour la validation", context);
                }

              },child: new Text("Valider"),),

            ],

          );
        }
    );
  }
}