import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/login_courtier.dart';


class espace_courtier extends StatefulWidget{
  var cdata;
  espace_courtier(this.cdata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _espace_courtier(this.cdata);
  }

}




class _espace_courtier extends State<espace_courtier>{
  var cdata;
  _espace_courtier(this.cdata);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Espace Courtier"),centerTitle: true,backgroundColor: Orange,),
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

            Text("Mes Commandes",textAlign: TextAlign.center,textScaleFactor: 1.4,),
            Text(" Vous pouvez voir les details en cliquant sur la commande de votre choix ",textAlign: TextAlign.center,),
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
                stream: Firestore.instance.collection("client_services").where('id_livreur',isEqualTo:cdata[0]["id"].toString().trim()).snapshots(),
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
                              new Text("Kilo:"+snapshot.data.documents[index]["kilo"].toString(),textAlign: TextAlign.center,),
                              new Text("Prix:"+snapshot.data.documents[index]["prix"].toString()+" FCFA",textAlign: TextAlign.center,),
                              new Text("Client:"+snapshot.data.documents[index]["nom_client"],textAlign: TextAlign.center,),
                              new Text("Localisation:"+snapshot.data.documents[index]["localisation_client"],textAlign: TextAlign.center,),
                              new Text("Numéro_Client:"+snapshot.data.documents[index]["numero_client"]+"\n",textAlign: TextAlign.center,),
                          Center(child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Firestore.instance.collection("client_services").document(snapshot.data.documents[index].documentID).updateData({
                                    'etat':"A recuperer",
                                  }).catchError((err){
                                    print(err);
                                  });

                                },
                                child: new Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent),
                                  child: new Center(
                                    child: new Text("1"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Firestore.instance.collection("client_services").document(snapshot.data.documents[index].documentID).updateData({
                                    'etat':"traitement en cours",
                                  }).catchError((err){
                                    print(err);
                                  });

                                },
                                child: new Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
                                  child: new Center(
                                    child: new Text("2"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Firestore.instance.collection("client_services").document(snapshot.data.documents[index].documentID).updateData({
                                    'etat':"A Livrer",
                                  }).catchError((err){
                                    print(err);
                                  });

                                },
                                child: new Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.pinkAccent),
                                  child: new Center(
                                    child: new Text("3"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Firestore.instance.collection("client_services").document(snapshot.data.documents[index].documentID).updateData({
                                    'etat':"terminer",
                                  }).catchError((err){
                                    print(err);
                                  });

                                },
                                child: new Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.amberAccent),
                                  child: new Center(
                                    child: new Text("4"),
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

            ),
          ],
        ),
      ),
    );
  }

}

/*


 Center(child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent),
                                child: new Center(
                                  child: new Text("1"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
                                child: new Center(
                                  child: new Text("2"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                child: new Center(
                                  child: new Text("3"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.pink),
                                child: new Center(
                                  child: new Text("4"),
                                ),
                              ),
                            ),


                          ],
                        ),)
 */