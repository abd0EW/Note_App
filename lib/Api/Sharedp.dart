import 'package:shared_preferences/shared_preferences.dart';

class Sharedp {
  Future setAceestoken(String accesstoken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("accessToken", accesstoken);
  }

  Future<String?> getAceestoken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = await sharedPreferences.getString("accessToken");
    return token;
  }

  Future setRefreshtoken(String Refreshtoken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("refreshToken", Refreshtoken);
  }

  Future<String?> getRefreshtoken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = await sharedPreferences.getString("refreshToken");
    return token;
  }

  Future<void> re() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("accessToken");
  }
}
