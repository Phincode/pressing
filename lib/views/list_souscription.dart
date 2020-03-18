import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';


class mes_abonnement extends StatefulWidget{
  var data;
  mes_abonnement(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _mes_abonnement(this.data);
  }

}

class _mes_abonnement extends State<mes_abonnement>{
  var data;
  _mes_abonnement(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Mes Abonnements"),centerTitle: true,backgroundColor: Orange,),
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
            Text("Mes Abonnements",textAlign: TextAlign.center,textScaleFactor: 1.4,),
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
             stream: Firestore.instance.collection("client_abonnement").where("id_client",isEqualTo: data[0]["id"]).snapshots(),
             builder: (BuildContext context,snapshot){
               if(snapshot.hasData){
                 return  Container(
                   height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
                   child: ListView.builder(itemCount: snapshot.data.documents.length ,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                     return new Container(
                       margin: EdgeInsets.only(bottom: 20),
                       height: 120,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: colorcheck(snapshot.data.documents[index]["etat"])),
                       child: new Center(
                         child: new ListView(
                           children: <Widget>[
                             new Text(snapshot.data.documents[index]["nom_packs"],textAlign: TextAlign.center,),
                             new Text("Date: "+snapshot.data.documents[index]["created"].toDate().toString(),textAlign: TextAlign.center,),
                             SizedBox(height: 10,),
                             new Text("Date Fin:",textAlign: TextAlign.center,),
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