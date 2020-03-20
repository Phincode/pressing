import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';


class Admin_abonnement extends StatefulWidget{

  Admin_abonnement();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Admin_abonnement();
  }

}

class _Admin_abonnement extends State<Admin_abonnement>{
  _Admin_abonnement();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Gestion Abonnements"),centerTitle: true,backgroundColor: Orange,),
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new ListView(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/2642430.jpg"),fit: BoxFit.cover)),
              ),
            ),
            Text("Liste Des Demandes",textAlign: TextAlign.center,textScaleFactor: 1.4,),
            Center(
              child:  Wrap(

                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.greenAccent),
                  ),
                  Text(" En attente "),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.pink),
                  ),
                  Text(" Validé."),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.orange),
                  ),
                  Text(" Terminé."),
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("client_abonnement").snapshots(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return  Container(
                    height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
                    child: ListView.builder(itemCount: snapshot.data.documents.length ,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                      return new Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: !(snapshot.data.documents[index]["etat"].toString().contains("en attente"))?colorcheck3(snapshot.data.documents[index]["etat"],snapshot.data.documents[index]["datefin"].toDate(),snapshot.data.documents[index].documentID):colorcheck(snapshot.data.documents[index]["etat"],)),
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              new Text(snapshot.data.documents[index]["nom_packs"],textAlign: TextAlign.center,),
                              new Text("Nom: "+snapshot.data.documents[index]["nom_client"].toString(),textAlign: TextAlign.center,),
                              new Text("Tel: "+snapshot.data.documents[index]["numero_client"].toString(),textAlign: TextAlign.center,),
                              new Text("Localisation: "+snapshot.data.documents[index]["localisation"].toString(),textAlign: TextAlign.center,),
                              new Text("Durée: "+snapshot.data.documents[index]["duree_abonnement"].toString(),textAlign: TextAlign.center,),
                              !(snapshot.data.documents[index]["etat"].toString().contains("en attente"))?new Text("Date debut: "+snapshot.data.documents[index]["created"].toDate().toString(),textAlign: TextAlign.center,):new Text(""),
                              !(snapshot.data.documents[index]["etat"].toString().contains("en attente"))?new Text("Date fin: "+snapshot.data.documents[index]["datefin"].toDate().toString(),textAlign: TextAlign.center,):new Text(""),
                              Center(child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                    },
                                    child: new Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                      child: new Center(
                                        child: new Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  !(snapshot.data.documents[index]["etat"].toString().contains("en attente"))?new Text(""):GestureDetector(
                                    onTap: (){
                                      var datefin=DateTime.now().add(Duration(days:int.parse(snapshot.data.documents[index]["duree_abonnement"].toString())));
                                      Firestore.instance.collection("client_abonnement").document(snapshot.data.documents[index].documentID).updateData({
                                        'created':DateTime.now(),
                                        'datefin':datefin,
                                        'etat':"valide"
                                      });
                                    },
                                    child: new Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                      child: new Center(
                                        child: new Icon(Icons.verified_user),
                                      ),
                                    ),
                                  ),





                                ],
                              ),)
                            ],
                          ),
                        ),
                      );
                    }),

                  );

                }
                return new Center(child: new Text("Wait..."),);
              },
            ),


          ],
        ),
      ),
    );
  }

}