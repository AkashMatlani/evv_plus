import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String isLoggedIn = "com.evv_plus.isLoggedIn";
  static const String nurseId = "com.evv_plus.user_id";
  static const String isInfoSliderShow = "com.evv_plus.info_slider";

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

  static void saveUserDataToPref(int nurseId) {
    PrefUtils.setIntValue(PrefUtils.nurseId, nurseId);
    PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
  }

  static void getUserDataFromPref() async {
    var _nurseId = await getValueFor(PrefUtils.nurseId);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
