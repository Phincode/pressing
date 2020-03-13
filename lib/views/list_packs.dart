import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/functions/get_storedData.dart';
import 'package:pressing/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'abonnement_form.dart';
import 'login.dart';


class list_packs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _list_packs();
  }

}

class _list_packs extends State<list_packs>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text("Nos Packs Abonnement"),centerTitle: true,backgroundColor: Orange,),
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
            Text(" Pour un nouvel abonnement Toucher le pack de votre choix! ",textAlign: TextAlign.center,),
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
              child: StreamBuilder(
                stream: Firestore.instance.collection("abonnement").snapshots(),
                builder: (BuildContext context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(itemCount:snapshot.data.documents.length,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                      return new GestureDetector(
                        onTap: (){
                          StoredData().then((d){
                            if(d!=null){
                              var abon={
                                "id":snapshot.data.documents[index].documentID,
                                "nom":snapshot.data.documents[index]["nom"],
                                "duree":snapshot.data.documents[index]["duree"]
                              };
                              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                return new Abonnement(d,abon);
                              }));

                            }else{
                              Toast.show("Veillez vous reconnecter svp",context,duration:5);
                              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                return new Login(0);
                              }));
                            }
                          });
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color:Color(0xFFefd807)),
                              child: new Center(
                                child: new ListView(
                                  children: <Widget>[
                                    new Text(snapshot.data.documents[index]["nom"]+"\n",textAlign: TextAlign.center,),
                                    Center(
                                      child: new Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image"]),fit: BoxFit.cover)),
                                      ),
                                    ),
                                    new Text(snapshot.data.documents[index]["prix"].toString()+" FCFA",textAlign: TextAlign.center,),
                                    new Text("Details:"+snapshot.data.documents[index]["description"],textAlign: TextAlign.center,),
                                    new Text("Durée:"+snapshot.data.documents[index]["duree"].toString()+" jours",textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                  return new Center(child: new CircularProgressIndicator(),);
                },
              )

            )


          ],
        ),
      ),
    );
  }

}
