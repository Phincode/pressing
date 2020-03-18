import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';


class espace_client extends StatefulWidget{
  var data;
  espace_client(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _espace_client(this.data);
  }

}

class _espace_client extends State<espace_client>{
  var data;
  _espace_client(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Espace Client"),centerTitle: true,backgroundColor: Orange,),
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

            Text("Mes Demandes",textAlign: TextAlign.center,textScaleFactor: 1.4,),
            Text("Ici vous pouvez suivre en temps réel vos demande de service à domicile",textAlign: TextAlign.center,),
            Wrap(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.greenAccent),
                ),
                Text(" A récuperer  "),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.orangeAccent),
                ),
                Text(" Traitement en cours "),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.pinkAccent),
                ),
                Text(" A livrer "),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.amberAccent),
                ),
                Text(" Terminer."),
              ],
            ),
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
              child: StreamBuilder(
                stream: Firestore.instance.collection("client_services").where('id_client',isEqualTo:data[0]["id"]).orderBy("created",descending: true)  .snapshots(),
                builder: (BuildContext context,snapshot){
                  if(snapshot.hasData){
                    return  ListView.builder(itemCount:snapshot.data.documents.length,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                      return new Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: colorcheck2(snapshot.data.documents[index]["etat"])),
                        child: new Center(
                          child: new ListView(
                            children: <Widget>[
                              new Text("Description:"+snapshot.data.documents[index]["description_demande"],textAlign: TextAlign.center,),
                              new Text("Etat:"+snapshot.data.documents[index]["etat"],textAlign: TextAlign.center,),
                              new Text("Kilo:"+snapshot.data.documents[index]["kilo"].toString(),textAlign: TextAlign.center,),
                              new Text("Prix:"+snapshot.data.documents[index]["prix"].toString()+" FCFA",textAlign: TextAlign.center,),
                              new Text("Courtier:"+snapshot.data.documents[index]["nom_livreur"],textAlign: TextAlign.center,),
                              new Text("Numéro_Courtier:"+snapshot.data.documents[index]["numero_livreur"],textAlign: TextAlign.center,),
                              Center(child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: new Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                      child: new Center(
                                        child: new Icon(Icons.add_to_photos),
                                      ),
                                    ),
                                  ),





                                ],
                              ),)
                            ],
                          ),
                        ),
                      );
                    });


                  }
                  return Center(child:new Text("Loading..."));
                },
              ),

            )


          ],
        ),
      ),
    );
  }

}