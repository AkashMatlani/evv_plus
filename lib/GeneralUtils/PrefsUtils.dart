import 'package:evv_plus/Models/NurseResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String isLoggedIn = "com.evv_plus.isLoggedIn";
  static const String nurseId = "com.evv_plus.nurseId";
  static const String password = "com.evv_plus.password";
  static const String isFirstTimeLogin = "com.evv_plus.isFirstTimeLogin";

  static setStringValue(String key, String defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, defaultValue);
  }

  static setIntValue(String key, int defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, defaultValue);
  }

  static setDoubleValue(String key, double defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, defaultValue);
  }

  static setBoolValue(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefUtils.setBoolValue(PrefUtils.isLoggedIn, false);
    prefs.clear();
  }

  static void saveUserDataToPref(NurseResponse nurseDetails) {
    PrefUtils.setIntValue(PrefUtils.nurseId, nurseDetails.nurseid);
    PrefUtils.setStringValue(PrefUtils.password, nurseDetails.password);
    PrefUtils.setBoolValue(PrefUtils.isFirstTimeLogin, nurseDetails.isFirtsTimeLogin);
    PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
  }

  static void getNurseDataFromPref() async {
    var _nurseId = await getValueFor(PrefUtils.nurseId);
    var _password = await getValueFor(PrefUtils.password);
    var _isLoggedIn = await getValueFor(PrefUtils.isLoggedIn);
    var _isFirstTimeLogin = await getValueFor(PrefUtils.isFirstTimeLogin);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
