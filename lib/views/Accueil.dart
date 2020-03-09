import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/inscription.dart';

import 'login.dart';


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
                  child: new Text("Nos Services",textAlign: TextAlign.center,style: TextStyle(color: Orange), textScaleFactor: 1.3,),
                ),

                Container(
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
                                      new Text(" "+snapshot.data.documents[index]["prix"].toString()+ " FCFA"),
                                      SizedBox(height: 5,),
                                      GestureDetector(
                                        onTap: (){
                                          print("$index");
                                        },
                                        child: new Container(
                                          height: 20,
                                          width: 100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                          child: new Center(child: new Text("Commander",style: TextStyle(color: Colors.white),),),
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
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new inscription();
                            }));
                            break;
                          case 2:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new Login();
                            }));

                          break;
                          case 3:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new Login();
                            }));

                            break;
                          case 4:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new Login();
                            }));

                            break;
                          case 5:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new Login();
                            }));

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