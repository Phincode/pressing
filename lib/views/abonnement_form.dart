import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';


class Abonnement extends StatefulWidget{
  var data;
  var dataAbonnement;
  Abonnement(this.data,this.dataAbonnement);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Abonnement(this.data,this.dataAbonnement);
  }

}

class _Abonnement extends State<Abonnement>{
  var data;
  var dataAbonnement;
  final nom=TextEditingController();
  final numero=TextEditingController();
  final localisation=TextEditingController();
  final duree=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _Abonnement(this.data,this.dataAbonnement);
  void setdata(){
    setState(() {
      nom.text =data[0]["nom"];
      numero.text=data[0]["telephone"];
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(data.toString()+" "+dataAbonnement.toString());
    //init data
    //setdata();
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
            Text("Abonnement :"+ dataAbonnement["nom"]+" .\nVeillez soumettre ce formulaire! ",textAlign: TextAlign.center,),
            Container(
                height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2.9),
                child: Form(
                  key: _formKey,
                  child: ListView(
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
                        decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Durée de l'Abonnement en jours",labelText: "Durée de l'Abonnement en jours"),
                        keyboardType: TextInputType.number,
                        validator: (d){
                          if(d.isNotEmpty && int.parse(d)>=dataAbonnement["duree"]){
                            return null;
                          }
                          return 'Durée non valide, la durée doit Etre > '+dataAbonnement["duree"].toString();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: new RaisedButton(onPressed: (){
                          if(_formKey.currentState.validate()){
                            Toast.show("Veillez patienter...", context,duration: 160);
                            Firestore.instance.collection("client_abonnement").document().setData({
                              "duree_abonnement":duree.value.text,
                              "etat":"En attente",
                              "id_client":data[0]["id"],
                              "id_packs":dataAbonnement["id"],
                              "nom_client":nom.value.text,
                              "nom_packs":dataAbonnement["nom"],
                              "numero_client":numero.value.text,
                              "localisation":localisation.value.text,
                              'created': FieldValue.serverTimestamp(),
                            }).then((v){
                              Toast.show("Abonnement Enregistré, veillez garder votre téléphone pret de vous.\n Nous vous contacterons pour la confirmation",context,duration: 7);
                            },onError: (err){
                              Toast.show(err, context);
                            });
                            
                          }

                         },
                          color: Orange,
                          child: new Text("Valider"),
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

}
