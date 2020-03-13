import 'package:cloud_firestore/cloud_firestore.dart';
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
            Text("Demande de prestation : Veillez soumettre ce formulaire! ",textAlign: TextAlign.center,),
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
                      decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Description du service: ",labelText: "Description du service"),
                      keyboardType: TextInputType.text,
                      maxLines: 4,
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
                        if(_formKey.currentState.validate()){
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
                            'kilo':0,
                            'prix':0,
                            'etat':"En attente",


                          }).then((v){
                            Toast.show("Demande Enregistré, veillez garder votre téléphone pret de vous.\n Nous vous contacterons pour la confirmation et le prix",context,duration: 7);
                            Navigator.pop(context);
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
