import 'package:flutter/material.dart';
import 'package:pressing/functions/inscriptionUser.dart';
import 'package:pressing/style/style.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class inscription extends StatefulWidget{
  int index;
  inscription(this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _inscription(this.index);
  }

}

class _inscription extends State<inscription>{

  int index;
  final Nomctr=TextEditingController();
  final Telephonectr=TextEditingController();
  final Passwordctr=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _inscription(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: new Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 0.0,
              child: new Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/3.4,
              right: 0.0,
              child: new Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/1.1,
              right: 0.0,
              child: new Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.deepPurple),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/1.1,
              left: 0.0,
              child: new Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.indigo),
              ),
            ),
            ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                new Center(
                  child: Container(
                    width:100,
                    height: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle,color: Orange),
                    child: new Center(child: new Text("MP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2,),),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                new Card(
                  elevation: 4,
                  child:Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                        Center(child: Text("Inscription",textAlign: TextAlign.center,textScaleFactor: 1.3,),),
                          new Wrap(
                            children: <Widget>[
                              new Center(child: new Text("Vous avez déjà un compte ?",textAlign: TextAlign.center,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return Login(index);
                                  }));
                                },
                                child: new Center(child: new Text("Connectez-vous!",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(color: Colors.deepPurple,decoration: TextDecoration.underline),),),
                              ),

                            ],
                          ),
                             new TextFormField(
                               controller: Nomctr,
                              decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Nom"),
                               keyboardType: TextInputType.text,
                               validator: (N){
                                 if(N.isNotEmpty){
                                   return null;
                                 }
                                 return "Nom obligatoire";
                               },
                            ),
                          SizedBox(height: 10,),
                          new TextFormField(
                            controller: Telephonectr,
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Téléphone"),
                            keyboardType: TextInputType.phone,
                            validator: (T){
                              if(T.isNotEmpty && T.contains("+")){
                                return null;
                              }
                              return "Téléphone vide ou non valide";
                            },
                          ),
                          SizedBox(height: 10,),
                          new TextFormField(
                            controller: Passwordctr,
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Password"),
                            keyboardType: TextInputType.text,
                            validator: (p){
                              if(p.isNotEmpty){
                                return null;
                              }
                              return "Le mot de passe ne doit pas etre vide";
                            },
                          ),
                          SizedBox(height: 10,),
                         GestureDetector(
                           onTap: (){
                             if(_formKey.currentState.validate()){
                               Toast.show("Veillez patienter...", context,duration: 160);
                               incriptionUser(Nomctr.value.text,Telephonectr.value.text,Passwordctr.value.text,context,index);

                             }
                           },
                           child:  new Center(
                             child: Container(
                               width:60,
                               height: 60,
                               decoration: BoxDecoration(shape: BoxShape.circle,color: Orange),
                               child: new Center(child:new Icon(Icons.navigate_next,color: Colors.white,size: 50,),),
                             ),
                           ),
                         )
                        ],
                      ),
                    ),

                  ) ,
                ),



              ],
            ),

          ],
        ),
      ),
    );
  }

}