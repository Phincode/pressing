import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pressing/views/Accueil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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
                // go to Abonnement
                break;
              case 2:
                //go to prestation simle
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