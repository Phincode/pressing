import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';


class admin_espace_gestion_services extends StatefulWidget{

  admin_espace_gestion_services();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _admin_espace_gestion_services();
  }

}

class _admin_espace_gestion_services extends State<admin_espace_gestion_services>{
  final scroocontroller=ScrollController();
  var id_livreur="";
  var nom_livreur="";
  var tel_livreur="";

  var cl=Colors.white;

  final price=TextEditingController();


  _admin_espace_gestion_services();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Demande Service"),centerTitle: true,backgroundColor: Orange,),
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

            Text("Liste Demandes",textAlign: TextAlign.center,textScaleFactor: 1.4,),
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
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2),
              child: StreamBuilder(
                stream: Firestore.instance.collection("client_services").orderBy("created",descending: true).snapshots(),
                builder: (BuildContext context,snapshot){
                  if(snapshot.hasData){
                    return  ListView.builder(itemCount:snapshot.data.documents.length,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                      return new Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: colorcheck2(snapshot.data.documents[index]["etat"])),
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              new Text("Description:"+snapshot.data.documents[index]["description_demande"],textAlign: TextAlign.center,),
                              new Text("Etat:"+snapshot.data.documents[index]["etat"],textAlign: TextAlign.center,),
                              new Text("Kilo:"+snapshot.data.documents[index]["kilo"].toString(),textAlign: TextAlign.center,),
                              new Text("Prix:"+snapshot.data.documents[index]["prix"].toString()+" FCFA",textAlign: TextAlign.center,),
                              new Text("Courtier:"+snapshot.data.documents[index]["nom_livreur"],textAlign: TextAlign.center,),
                              Center(child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      more(snapshot.data.documents[index]["liste_vetement"].toString(),snapshot.data.documents[index].documentID,snapshot.data.documents[index]["localisation_client"].toString(),snapshot.data.documents[index]["numero_client"].toString());
                                    },
                                    child: new Container(
                                      height: 40,
                                      width: 40,
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
  void more(String text,var id,String localisation,String contact){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: new Text("Informations",textAlign: TextAlign.center,),
            content: new Container(
              height: 300,
              width: 300,
              child:new ListView(
                    controller: scroocontroller,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      new Divider(height: 10,color: Colors.white,thickness: 2,),
                      new SelectableText("Contact: "+contact),
                      new Text("Localisation: "+localisation),
                      new Text("Vetements: "+text),
                      new Text("Pour valider veillez ajouter ces informations:\n"),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Entrer le Prix"),
                        keyboardType: TextInputType.phone,
                        controller: price,
                      ),
                      new Text("\n"),
                      new Text("Choisissez le courtier:\n"),
                      Container(
                        width: 300,
                        height: 100,
                        child: new StreamBuilder(
                            stream: Firestore.instance.collection("courtier").snapshots(),
                            builder: (BuildContext context,snapshot){
                                if(snapshot.hasData){
                                   if(snapshot.data.documents.length!=0){
                                     return new ListView.builder( itemCount: snapshot.data.documents.length,scrollDirection: Axis.horizontal,itemBuilder: (BuildContext context,index){
                                       return new GestureDetector(
                                         onTap: (){
                                           setState(() {
                                             id_livreur=snapshot.data.documents[index].documentID;
                                             nom_livreur=snapshot.data.documents[index]["nom"];
                                             tel_livreur=snapshot.data.documents[index]["telephone"];
                                           });
                                           print(id_livreur);
                                         },
                                         child: Container(
                                           height: 80,
                                           width: 80,
                                           decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                           child: new Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Icon(Icons.account_circle,color: Orange,),
                                               new Text(snapshot.data.documents[index]["nom"]),
                                             ],
                                           ),
                                         ),
                                       );
                                     });
                                   }else{
                                     return new Text("Aucun courtier...");
                                   }
                                   
                                  
                                }
                                return new Text("Loading...");
                            }
                        ),
                      ),
                      new Text("Courtier: $nom_livreur"),

                    ],
                  )
            ),
            actions: <Widget>[
              new RaisedButton(onPressed: (){
                   Navigator.pop(context);
               },child: new Text("Fermer"),),
              new RaisedButton(onPressed: (){
                 if(price.value.text.isNotEmpty && id_livreur.isNotEmpty ){
                   Toast.show("Traitement en cours", context,duration: 160);
                   Firestore.instance.collection("client_services").document(id).updateData({
                     'etat':'A recuperer',
                     'id_livreur':id_livreur.toString(),
                     'nom_livreur':nom_livreur.toString(),
                     'numero_livreur':tel_livreur.toString(),
                     'prix':int.parse(price.value.text),
                   }).then((v){
                     Toast.show("Ok", context);
                     price.clear();
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