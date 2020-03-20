import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';

class catalogue extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _catalogue();
  }

}

class _catalogue extends State<catalogue>{
  var data;

  final numero=TextEditingController();
  File img;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      floatingActionButton: new RaisedButton.icon(onPressed: (){
        more();
      }, icon: Icon(Icons.add), label: new Text("Ajouter")),
      appBar:new AppBar(
        backgroundColor: Orange,
        title: new Text("Catalogue",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new StreamBuilder(
            stream: Firestore.instance.collection("vetements").snapshots(),
            builder: (BuildContext context,snapshot){
              if(snapshot.hasData){
                if(!snapshot.data.documents.isEmpty){
                  return new ListView.builder(itemCount: snapshot.data.documents.length,itemBuilder: (BuildContext context,index){
                    return new Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child:new Row(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image"]),fit: BoxFit.fill)),
                          ),
                          SizedBox(width: 30,),
                          new Text(snapshot.data.documents[index]["nom"].toString()),
                          IconButton(icon: Icon(Icons.delete),onPressed: (){
                            Firestore.instance.collection("vetements").document(snapshot.data.documents[index].documentID).delete();
                          },)
                        ],
                      ) ,
                    );
                  });
                }else{
                  return new Center(child: new Text("Oups...Aucune données revenez plus tard!"),);
                }
              }
              return new Center(child: new Text("Loading..."),);
            }
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
            title: new Text("Tarif Services",textAlign: TextAlign.center,),
            content: new Container(
                height: 300,
                width: 300,
                child:new ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    new Divider(height: 10,color: Colors.white,thickness: 2,),
                    new Text("Pour Ajouter un vetement veillez soumettre ces informations:\n"),
                    new Text("Image de préference 75 x 77:\n"),
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
                      decoration: InputDecoration(hintText: "Nom"),
                      keyboardType: TextInputType.text,
                      controller: numero,
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
                if(numero.value.text.isNotEmpty  && img!=null){
                  StorageReference storageReference = FirebaseStorage().ref();
                  var uploadTask = storageReference
                      .child("vetement")
                      .child(DateTime.now().toString())
                      .putFile(img);
                  var storageSnapshot = await uploadTask.onComplete;
                  var url = await storageSnapshot.ref.getDownloadURL();

                  Firestore.instance.collection("vetements").document().setData({
                    'nom':numero.value.text,
                    'image':url.toString(),
                    'created':FieldValue.serverTimestamp()
                  }).then((v){
                    Toast.show("ok", context);
                    numero.clear();
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
