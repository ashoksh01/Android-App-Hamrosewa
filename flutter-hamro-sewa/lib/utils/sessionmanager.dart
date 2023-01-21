import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String authtoken = "token";

//set data into shared preferences like this
  Future<void> setAuthToken(String? authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authtoken, authToken!);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken1;

    authToken1 = pref.getString(authtoken).toString();
    return authToken1;
  }
}



//  SessionManager().setAuthToken(token!);
//         Future<String> data1 = SessionManager().getAuthToken();
       

//         print(
//             "yo chai sdfgfgession bata aayooooooofgfdgfdgfdgfdgdfgooooooooooooo");
//         data1.then((value) {
//           print(value);
//         });
