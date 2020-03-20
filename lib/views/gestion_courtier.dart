import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';


class Gestion_courtier extends StatefulWidget{

  Gestion_courtier();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Gestion_courtier();
  }

}

class _Gestion_courtier extends State<Gestion_courtier>{
  final nom=TextEditingController();

  final prenom=TextEditingController();

  final numero=TextEditingController();

  final zone=TextEditingController();

  final password=TextEditingController();

  _Gestion_courtier();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: new RaisedButton.icon(onPressed: (){
        more();
       }, icon: Icon(Icons.add), label: new Text("Ajouter")),
      appBar: AppBar(title: new Text("Gestion Courtier"),centerTitle: true,backgroundColor: Orange,),
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
            Text("Liste Des Courtiers",textAlign: TextAlign.center,textScaleFactor: 1.4,),
            StreamBuilder(
              stream: Firestore.instance.collection("courtier").snapshots(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return  Container(
                    height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
                    child: ListView.builder(itemCount: snapshot.data.documents.length ,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                      return new Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.orangeAccent),
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              new Text(snapshot.data.documents[index]["nom"],textAlign: TextAlign.center,),
                              new Text(snapshot.data.documents[index]["prenom"].toString(),textAlign: TextAlign.center,),
                              new Text("Tel: "+snapshot.data.documents[index]["telephone"].toString(),textAlign: TextAlign.center,),
                              new Text("Zone: "+snapshot.data.documents[index]["zone"].toString(),textAlign: TextAlign.center,),
                              Center(child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Firestore.instance.collection("courtier").document(snapshot.data.documents[index].documentID).delete();
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
  void more(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            backgroundColor: Colors.orangeAccent,
            title: new Text("Ajout Courtier",textAlign: TextAlign.center,),
            content: new Container(
                height: 300,
                width: 300,
                child:new ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    new Divider(height: 10,color: Colors.white,thickness: 2,),
                    new Text("Pour Ajouter un courtier veillez soumettre ces informations:\n"),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Nom"),
                      keyboardType: TextInputType.text,
                      controller: nom,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Prenom"),
                      keyboardType: TextInputType.text,
                      controller: prenom,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Numero"),
                      keyboardType: TextInputType.phone,
                      controller: numero,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Zone"),
                      keyboardType: TextInputType.text,
                      controller:zone,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
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
              new RaisedButton(onPressed: (){
                Toast.show("Traitement en cours...", context,duration: 160);
                if(nom.value.text.isNotEmpty && prenom.value.text.isNotEmpty && numero.value.text.isNotEmpty && zone.value.text.isNotEmpty && password.value.text.isNotEmpty){
                  Firestore.instance.collection("courtier").document().setData({
                    'nom':nom.value.text,
                    'prenom':prenom.value.text,
                    'password':password.value.text,
                    'telephone':numero.value.text,
                    'zone':zone.value.text,
                    'created':FieldValue.serverTimestamp()
                  }).then((v){
                    Toast.show("ok", context);
                    nom.clear();
                    prenom.clear();
                    password.clear();
                    numero.clear();
                    zone.clear();
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