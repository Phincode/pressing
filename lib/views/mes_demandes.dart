import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';


class Prestation_demande extends StatefulWidget{
  var data;
  Prestation_demande(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Prestation_demande(this.data);
  }

}

class _Prestation_demande extends State<Prestation_demande>{
  var data;

  final nom=TextEditingController();
  final numero=TextEditingController();
  final localisation=TextEditingController();
  final duree=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isfinish=false;

  String tex="suivant";

  String vetement="";

  final quantite=TextEditingController();
  final scroocontroller=ScrollController();

  var resume="";
  _Prestation_demande(this.data);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nom.text=data[0]["nom"];
    numero.text=data[0]["telephone"];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //init data
    print(data.toString());
    //setdata();
    return Scaffold(
      appBar: AppBar(title: new Text("Demande de service"),centerTitle: true,backgroundColor: Orange,),
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
            isfinish?Text("Astuce: Veillez toucher le vetement de votre choix et préciser la quantité pour l'ajouter! une fois l'ajout terminé toucher le bouton 'valider' pour soumettre votre demande.\n Glisser la vue vers le haut pour voir tout le formulaire",textAlign: TextAlign.center,):new Text(""),
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
              child: Form(
                key: _formKey,
                child: isfinish? ListView(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: new Center(
                        child: StreamBuilder(
                          stream: Firestore.instance.collection("vetements").snapshots(),
                          builder: (BuildContext context,snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(scrollDirection: Axis.horizontal,padding: EdgeInsets.all(20),itemCount: snapshot.data.documents.length,itemBuilder: (BuildContext context,index){
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      vetement="";
                                      vetement=snapshot.data.documents[index]["nom"].toString();
                                    });
                                  },
                                  child: new Container(
                                    margin: EdgeInsets.only(right: 20),
                                    width: 50,
                                    height: 50,
                                    decoration:BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image"]),fit: BoxFit.fill)) ,
                                  ),
                                );
                              });
                            }
                            return new Text("Loading...");
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    new Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        new Text(vetement),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: new TextFormField(
                        onChanged: (c){
                          if(vetement.isEmpty){
                            quantite.clear();
                          }
                        },
                        controller: quantite,
                        decoration: InputDecoration(hintText: "quantité"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(child: GestureDetector(
                      onTap: (){
                        if(vetement.isNotEmpty && quantite.value.text.isNotEmpty){
                          setState(() {
                            resume=resume+" "+quantite.value.text.toString()+" "+vetement;
                            vetement="";
                          });
                          quantite.clear();
                        }else{
                          Toast.show("Astuce: cliquer sur un vetement, ensuite préciser la quantité", context,backgroundColor: Colors.red);

                        }
                      },
                      child: new Icon(Icons.add_to_photos,size: 30,),
                    ),),
                    SizedBox(height: 30,),
                    new Wrap(
                      children: <Widget>[
                        Center(child:  new Text("Résumé:$resume",textAlign: TextAlign.center,),),
                        SizedBox(height: 40,),
                        new Center(child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new FlatButton.icon(onPressed:(){
                                if(resume.isEmpty){
                                  Toast.show("Veillez cliquer sur le bouton + pour ajouter des vetements", context,backgroundColor: Colors.red);
                                }else{
                                  Toast.show("Veillez patienter...", context,duration: 160);
                                  Firestore.instance.collection("client_services").document().setData({
                                    'id_client':data[0]["id"],
                                    'nom_client':nom.value.text,
                                    'numero_client':numero.value.text,
                                    'localisation_client':localisation.value.text,
                                    'description_demande':duree.value.text,
                                    'id_livreur':"",
                                    'nom_livreur':"",
                                    'numero_livreur':"",
                                    'liste_vetement':resume,
                                    'kilo':0,
                                    'prix':0,
                                    'etat':"En attente",
                                    'created': FieldValue.serverTimestamp(),

                                  }).then((v){
                                    Toast.show("Demande Enregistré, veillez garder votre téléphone pret de vous.\n Nous vous contacterons pour la confirmation et le prix",context,duration: 7);
                                    succes();

                                  },onError: (err){
                                    Toast.show(err, context);
                                  });
                                }

                              }, icon:Icon(Icons.check,size: 30,), label: new Text("Valider",textScaleFactor: 1.2,)),
                              new FlatButton.icon(onPressed:(){
                                setState(() {
                                  resume="";
                                });

                              }, icon:Icon(Icons.delete,size: 30,), label: new Text("Effacer",textScaleFactor: 1.2,)),
                            ],
                          ),),

                      ],
                    ),
                  ],

                ):ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    new TextFormField(
                      controller: nom,
                      decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Nom",labelText: "Nom"),
                      keyboardType: TextInputType.text,
                      validator: (N){
                        if(N.isNotEmpty){
                          return null;
                        }
                        return 'Le Nom ne doit pas Etre vide';
                      },
                    ),
                    new TextFormField(
                      controller: numero,
                      decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Numéro",labelText: "Numéro"),
                      keyboardType: TextInputType.phone,
                      validator: (n){
                        if(n.isNotEmpty){
                          return null;
                        }
                        return 'Le Numéro ne doit pas Etre vide';
                      },
                    ),
                    new TextFormField(
                      controller: localisation,
                      decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Localisation",labelText: "Localisation"),
                      keyboardType: TextInputType.text,
                      validator: (L){
                        if(L.isNotEmpty){
                          return null;
                        }
                        return 'La localisation est obligatoire';
                      },
                    ),
                    new TextFormField(
                      controller: duree,
                      decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Exemple:lavage à sec,repassage,lavage etc... ",labelText: "Description du service"),
                      keyboardType: TextInputType.text,
                      validator: (d){
                        if(d.isNotEmpty ){
                          return null;
                        }
                        return 'Veillez préciser svp le service';
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: new RaisedButton(onPressed: (){
                        if(_formKey.currentState.validate() && !isfinish){
                          setState(() {
                            isfinish=true;
                            tex="Terminer";
                          });
                            astuce();
                        }

                       /*


                        if(isfinish){


                        }
                        */

                      },
                        color: Orange,
                        child: new Text(tex),
                      ),
                    ),

                  ],
                ),
              ),

            )


          ],
        ),
      ),
    );

  }
  void astuce(){
    showDialog(context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
          return new AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: new Text("Astuces",textAlign: TextAlign.center,),
            content: new Container(
              height: 300,
              width: 300,
              child: DraggableScrollbar.semicircle(
                alwaysVisibleScrollThumb: true,
                controller: scroocontroller,
                  child: new ListView(
                    controller: scroocontroller,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      new Divider(height: 10,color: Colors.white,thickness: 2,),
                      new Text("1.Choissisez un vetement en touchant la liste de vetement que vous verrez! la liste est scrollable de gauche à droite.\n"),
                      new Text("2.vous précisez la quantité dans le champs 'quantité'.\n"),
                      new Text("3.Vous toucher le bouton '+' en bas de  'quantité'.\n"),
                      new Text("4.Votre choix s'affichera dans le résumé, en bas du bouton  '+'.\n"),
                      new Text("5.Vous avez la possibilité de choisir et d'ajouter autant de vetement que vous désirez'+'.\n"),
                      new Text("6.Si vous avez fini d'ajouter, toucher le bouton 'Valider' pour soumettre le formulaire+'.\n"),
                      new Divider(height: 10,color: Colors.white,thickness: 2,)
                    ],
                  )),
            ),
            actions: <Widget>[
              new RaisedButton(onPressed: (){
                Navigator.pop(context);
               },child: new Text("J'ai compris"),),

            ],

          );
      }
    );
  }
  void succes(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: new Text("Informations",textAlign: TextAlign.center,),
            content: new Container(
              height: 300,
              width: 300,
              child: new ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  new Divider(height: 10,color: Colors.white,thickness: 2,),
                  new Text("Votre demande a bien été enregistré, nous vous contacterons pour la validation.\n"),
                  new Text("Vous pouvez suivre l'état de votre demande dans votre espace client.\n"),
                  new Text("pour toutes informations complémentaire veillez nous joindre au 22549896203.\n"),
                  new Divider(height: 10,color: Colors.white,thickness: 2,)
                ],
              ),
            ),
            actions: <Widget>[
              new RaisedButton(onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
               },child: new Text("J'ai compris"),),

            ],

          );
        }
    );
  }

}
