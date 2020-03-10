import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/style/style.dart';


class espace_courtier extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _espace_courtier();
  }

}

class _espace_courtier extends State<espace_courtier>{
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
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.orange),
                ),
                Text(" Traitement en cours "),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.green),
                ),
                Text(" A livrer "),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.pink),
                ),
                Text(" Terminer."),
              ],
            ),
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
              child: ListView.builder(itemCount: 10,scrollDirection: Axis.vertical,padding: EdgeInsets.all(20),itemBuilder: (BuildContext context,index){
                return new Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.greenAccent),
                  child: new Center(
                    child: new ListView(
                      children: <Widget>[
                        new Text("Laver & Repasser",textAlign: TextAlign.center,),
                        new Text("Prix:500 FCFA",textAlign: TextAlign.center,),
                        new Text("Nom: Mr Koné",textAlign: TextAlign.center,),
                        new Text("Numéro:00220077",textAlign: TextAlign.center,),
                        new Text("Localisation:Marcory GFCI",textAlign: TextAlign.center,),
                        new Text("Date:22/02/2020",textAlign: TextAlign.center,),
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
                      ],
                    ),
                  ),
                );
              }),

            )


          ],
        ),
      ),
    );
  }

}