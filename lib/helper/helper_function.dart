import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey  = "USEREMAILKEY";

  static Future<bool?> saveUserLoggedInStatus(bool userLoggedIn) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoggedInKey,userLoggedIn);
  }

  static Future<bool?> getUserLoggedInStatus() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.getBool(userLoggedInKey,);
  }

}