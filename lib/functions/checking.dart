import 'package:shared_preferences/shared_preferences.dart';


Future<bool> check_user() async {
  bool res=false;
  SharedPreferences prefs= await SharedPreferences.getInstance();
  if(prefs.containsKey("userdata")){
    res=true;
  }

  return res;
}



Future<bool> check_courtier() async {
  bool res=false;
  SharedPreferences prefs= await SharedPreferences.getInstance();
  if(prefs.containsKey("courtierdata")){
    res=true;
  }

  return res;

}