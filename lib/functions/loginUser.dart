import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/Accueil.dart';
import 'package:pressing/views/espace_courtier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'get_storedData.dart';

loginUser(telephone,password,context,index) async {

  String message="";
 await Firestore.instance.collection("user").where("telephone",isEqualTo:telephone.toString()).where("password",isEqualTo: password.toString()).limit(1).snapshots()
  .listen((data){
    if(data.documents.isNotEmpty){
       data.documents.forEach((doc) async {
         print(doc.documentID);
         print(doc["nom"]);
          SharedPreferences prefs=await SharedPreferences.getInstance();
          if(prefs.containsKey("userdata")){
          }else{
            var udata=[{
              "id":doc.documentID,
             "nom":doc["nom"],
             "telephone":doc["telephone"],
            }];
            prefs.setString("userdata",jsonEncode(udata));
            message="Bienvenue :"+doc["nom"].toString();
            Toast.show(message, context);
            switch(index){
              case 0:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new Accueil();
                }));
                break;
              case 1:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new Accueil();
                }));
                break;
              case 2:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new Accueil();
                }));
                break;
              case 3:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return Accueil();
                }));
                break;
              case 4:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return Accueil();
                }));
                break;
              case 5:
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new Accueil();
                }));
                break;
            }
          }
       });
    }else{
      message="Login ou mot de passe incorrecte";
      Toast.show(message, context);
    }
 });

}


loginCour(telephone,password,context,index) async {

  String message="";
  await Firestore.instance.collection("courtier").where("telephone",isEqualTo:telephone.toString()).where("password",isEqualTo: password.toString()).limit(1).snapshots()
      .listen((data){
    if(data.documents.isNotEmpty){
      data.documents.forEach((doc) async {
        print(doc.documentID);
        print(doc["nom"]);
        SharedPreferences prefs=await SharedPreferences.getInstance();
        if(prefs.containsKey("courtierdata")){
        }else{
          var cdata=[{
            "id":doc.documentID,
            "nom":doc["nom"],
            "telephone":doc["telephone"],
          }];
          prefs.setString("courtierdata",jsonEncode(cdata));
          message="Bienvenue :"+doc["nom"].toString();
          Toast.show(message, context);
          switch(index){
            case 0:
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                return new Accueil();
              }));
              break;
            case 1:
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                return new Accueil();
              }));
              break;
            case 2:
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                return new Accueil();
              }));
              break;
            case 3:
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                return Accueil();
              }));
              break;
            case 4:
              StoredDataC().then((v){
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new espace_courtier(v);
                }));
              });
              break;
            case 5:
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context){
                return new Accueil();
              }));
              break;
          }
        }
      });
    }else{
      message="Login ou mot de passe incorrecte";
      Toast.show(message, context);
    }
  });

}