import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressing/functions/calling.dart';
import 'package:pressing/functions/color_ckeck.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/tarif1.dart';
import 'package:toast/toast.dart';


class moderation_service extends StatefulWidget{

  moderation_service();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _moderation_service();
  }

}

class _moderation_service extends State<moderation_service>{
  final nom=TextEditingController();

  final prenom=TextEditingController();

  final numero=TextEditingController();

  final zone=TextEditingController();

  final password=TextEditingController();

  var img;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: new RaisedButton.icon(onPressed: (){
        more();
       }, icon: Icon(Icons.add), label: new Text("Ajouter")),
      appBar: AppBar(title: new Text("Moderation Services"),centerTitle: true,backgroundColor: Orange,),
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
            Text("Liste Des Services",textAlign: TextAlign.center,textScaleFactor: 1.4,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
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
                                        return new tarif1(snapshot.data.documents[index]);
                                      }));
                                    },

                                    child: new Container(
                                      height: 20,
                                      width: 100,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                      child: new Center(child: new Text("Voir les Tarifs",style: TextStyle(color: Colors.white),),),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      showDialog(context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context){
                                            return new AlertDialog(
                                              backgroundColor: Colors.orangeAccent,
                                              title: new Text("Supression",textAlign: TextAlign.center,),
                                              content: new Container(
                                                  height: 40,
                                                  width: 40,
                                                  child:new ListView(
                                                    scrollDirection: Axis.vertical,
                                                    children: <Widget>[
                                                      new Divider(height: 10,color: Colors.white,thickness: 2,),
                                                      new Text("Confirmer la supression\n"),
                                                    ],
                                                  )
                                              ),
                                              actions: <Widget>[
                                                new RaisedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                },child: new Text("Fermer"),),
                                                new RaisedButton(onPressed: (){
                                                  Toast.show("Traitement en cours...", context,duration: 160);
                                                  Firestore.instance.collection("services").document(snapshot.data.documents[index].documentID).delete();
                                                  Toast.show("ok", context);
                                                  Navigator.pop(context);
                                                 },child: new Text("Valider"),),

                                              ],

                                            );
                                          }
                                      );
                                    },

                                    child: new Container(
                                      height: 20,
                                      width: 100,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.black),
                                      child: new Center(child: new Text("Suprimer",style: TextStyle(color: Colors.white),),),
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
              ),
            )



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
            title: new Text("Ajout Services",textAlign: TextAlign.center,),
            content: new Container(
                height: 300,
                width: 300,
                child:new ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    new Divider(height: 10,color: Colors.white,thickness: 2,),
                    new Text("Pour Ajouter un service veillez soumettre ces informations:\n"),

                    TextFormField(
                      decoration: InputDecoration(hintText: "Numero d'appel "),
                      keyboardType: TextInputType.phone,
                      controller: numero,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Titre"),
                      keyboardType: TextInputType.text,
                      controller: password,
                    ),
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
                    )
                  ],
                )
            ),
            actions: <Widget>[
              new RaisedButton(onPressed: (){
                Navigator.pop(context);
              },child: new Text("Fermer"),),
              new RaisedButton(onPressed: () async {
                Toast.show("Traitement en cours...", context,duration: 160);
                if(numero.value.text.isNotEmpty  && password.value.text.isNotEmpty && img!=null){
                  StorageReference storageReference = FirebaseStorage().ref();
                  var uploadTask = storageReference
                      .child("services")
                      .child(DateTime.now().toString())
                      .putFile(img);
                  var storageSnapshot = await uploadTask.onComplete;
                  var url = await storageSnapshot.ref.getDownloadURL();

                  Firestore.instance.collection("services").document().setData({
                    'titre':password.value.text,
                    'action':numero.value.text,
                    'image':url.toString(),
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