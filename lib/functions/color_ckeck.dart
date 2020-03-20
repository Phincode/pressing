
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color colorcheck(String data){

  var color=Colors.greenAccent;

  if(data.contains("En atente")){

  }else if(data.contains("valide")){
    color=Colors.pinkAccent;
  }else if(data.contains("terminer")){
    color=Colors.orangeAccent;

  }

  return color;

}
Color colorcheck3(String data, DateTime date,id){

  var color=Colors.greenAccent;

  if(data.contains("En atente")){


  }else if(DateTime.now().isAfter(date)){
    Firestore.instance.collection("client_abonnement").document(id).updateData({
      'etat':'terminer'
    });
    color=Colors.orangeAccent;

  }else{
    color=Colors.pinkAccent;
  }

  return color;

}

Color colorcheck2(String data){

  var color=Colors.indigoAccent;

  if(data.contains("En atente")){

  }else if(data.contains("A recuperer")){
    color=Colors.greenAccent;
  }else if(data.contains("traitement en cours")){
    color=Colors.orangeAccent;

  }else if(data.contains("A Livrer")){
    color=Colors.pinkAccent;

  }else if(data.contains("terminer")){
    color=Colors.amberAccent;

  }

  return color;

}