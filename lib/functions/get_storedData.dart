import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future StoredData() async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  var data= jsonDecode(prefs.getString("userdata"));
  print(data.toString());
  return data;
}

Future StoredDataC() async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  var data= jsonDecode(prefs.getString("courtierdata"));
  print(data.toString());
  return data;
}