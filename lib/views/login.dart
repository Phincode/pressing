import 'package:flutter/material.dart';
import 'package:pressing/functions/loginUser.dart';
import 'package:pressing/style/style.dart';
import 'package:pressing/views/inscription.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget{
  int index;
  Login(this.index);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login(this.index);
  }

}

class _Login extends State<Login>{
  final telephonectr=TextEditingController();
  final passwordCtr=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int index;
  _Login(this.index);
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
                          Center(child: Text("Connexion",textAlign: TextAlign.center,textScaleFactor: 1.3,),),
                          new Wrap(
                            children: <Widget>[
                              new Center(child: new Text("Vous n'avez pas de compte?",textAlign: TextAlign.center,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return inscription(index);
                                  }));
                                },
                                child: new Center(child: new Text("Inscrivez vous!",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(color: Colors.deepPurple,decoration: TextDecoration.underline),),),
                              ),

                            ],
                          ),
                          SizedBox(height: 30,),
                          new TextFormField(
                            controller: telephonectr,
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Téléphone"),
                            keyboardType: TextInputType.phone,
                            validator: (t){
                              if(t.isNotEmpty && t.length>=8){
                                 return null;
                              }
                              return "telephone invalide";
                            },
                          ),
                          SizedBox(height: 20,),
                          new TextFormField(
                            controller: passwordCtr,
                            validator: (p){
                              if(p.isNotEmpty){
                                return null;
                              }
                              return "Mot de passe vide ou non valide";
                            },
                            decoration:InputDecoration(hasFloatingPlaceholder: true,hintText: "Password"),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10,),
                         GestureDetector(
                           onTap: (){
                             if(_formKey.currentState.validate()){
                               Toast.show("Veillez patienter...", context,duration: 160);
                               loginUser(telephonectr.value.text,passwordCtr.value.text,context,index);
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
                         ),
                        ],
                      ),
                    ),

                  ) ,
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}