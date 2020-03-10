import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

import 'loginUser.dart';

incriptionUser(nom,telephone,password,context,index) async {

  String message="";

  await Firestore.instance.collection("user").where("telephone",isEqualTo:telephone.toString()).snapshots()
      .listen((data) async {
    if(data.documents.isNotEmpty){
      message="Cet utilisateur existe déjà...\n Veillez vous Connecter!";
      Toast.show(message, context);
    }else{
      await Firestore.instance.collection('user').document()
          .setData({
        'nom': nom.toString(),
        'telephone': telephone.toString(),
        'password':password.toString()
      }).then((v){
        message="Inscription ok";
        Toast.show(message, context);
        loginUser(telephone,password,context,index);
      },onError: (err){
        message=err.toString();
        Toast.show(message, context);
      });

    }
  });


}