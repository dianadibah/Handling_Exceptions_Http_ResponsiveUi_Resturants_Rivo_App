import 'package:rivo_app/core/constant/pref_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunctions {
  GlobalFunctions._();
  static Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PrefKeys.token);
  }

  static Future<int> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getInt(PrefKeys.user);
    return user!;
  }

  static Future<bool> isAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey(PrefKeys.token);
  }

  static Future<void> setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(PrefKeys.token, token);
  }

  static Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(PrefKeys.token);
  }

  static Future<void> setUserId(int userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(PrefKeys.user, userId);
  }

  static Future<void> removeUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(PrefKeys.user);
  }

  static Future<bool> isFirstOpen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return !pref.containsKey(PrefKeys.isShowOnBorder);
  }

  static Future<void> setShowOnBoarder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(PrefKeys.isShowOnBorder, true);
  }

  static Future<void> logout() async {
    await removeToken();
    await removeUserId();
  }
}
