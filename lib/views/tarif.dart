import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pressing/style/style.dart';

class tarif extends StatefulWidget{
  var data;
  tarif(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tarif(this.data);
  }

}

class _tarif extends State<tarif>{
  var data;
  _tarif(this.data);
  @override
  Widget build(BuildContext context) {
    print(data);
    // TODO: implement build
    return new Scaffold(
      appBar:new AppBar(
        backgroundColor: Orange,
        title: new Text("Tarifs: "+data["titre"],style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
        new Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("assets/images/logoAccueil.PNG"),fit: BoxFit.cover)),
        ),
        SizedBox(width: 10,),
      ],
    ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new StreamBuilder(
            stream: Firestore.instance.collection("services_tarifs").where("id_service",isEqualTo:data.documentID).snapshots(),
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
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image_vetement"]),fit: BoxFit.cover)),
                          ),
                          SizedBox(width: 30,),
                          new Text("Prix: "+snapshot.data.documents[index]["prix"].toString()+" FCFA"),
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

}
