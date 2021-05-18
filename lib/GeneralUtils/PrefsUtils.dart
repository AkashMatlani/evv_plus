import 'package:evv_plus/Models/NurseResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String isLoggedIn = "com.evv_plus.isLoggedIn";
  static const String nurseId = "com.evv_plus.nurseId";
  static const String password = "com.evv_plus.password";
  static const String email = "com.evv_plus.email";
  static const String firstName = "com.evv_plus.firstName";
  static const String MiddleName = "com.evv_plus.middleName";
  static const String lastName = "com.evv_plus.lastname";
  static const String fullName = "com.evv_plus.fullname";
  static const String NurseImage = "com.evv_plus.nusrseImage";
  static const String Gender = "com.evv_plus.gender";
  static const String DateOfBirth = "com.evv_plus.dateOfBirth";
  static const String displayAddress = "com.evv_plus.displayAddress";
  static const String addressLineOne = "com.evv_plus.addressLineOne";
  static const String addressLineTwo = "com.evv_plus.addressLineTwo";
  static const String phoneNumber = "com.evv_plus.phoneNumber";
  static const String zipCode = "com.evv_plus.zipCode";
  static const String cityName="com.evv_plus.cityName";
  static const String stateName="com.evv_plus.stateName";
  static const String isFirstTimeLogin = "com.evv_plus.isFirstTimeLogin";
  static const String visitId = "com.evv_plus.visitId";

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

  static void saveNurseDataToPref(NurseResponse nurseDetails, String from) {
    PrefUtils.setIntValue(PrefUtils.nurseId, nurseDetails.nurseid);
    PrefUtils.setStringValue(PrefUtils.email, nurseDetails.email);
    PrefUtils.setStringValue(PrefUtils.firstName, nurseDetails.firstName);
    PrefUtils.setStringValue(PrefUtils.MiddleName, nurseDetails.middleName);
    PrefUtils.setStringValue(PrefUtils.lastName, nurseDetails.lastName);

    String nurseName = nurseDetails.firstName + " "+nurseDetails.lastName;
    PrefUtils.setStringValue(PrefUtils.fullName, nurseName);

    if(nurseDetails.nurseImage.split('/').last.isNotEmpty){
      PrefUtils.setStringValue(PrefUtils.NurseImage, nurseDetails.nurseImage);
    }else{
      PrefUtils.setStringValue(PrefUtils.NurseImage, "");
    }

    PrefUtils.setStringValue(PrefUtils.Gender, nurseDetails.gender);
    PrefUtils.setStringValue(PrefUtils.DateOfBirth, nurseDetails.dateOfBirth);
    PrefUtils.setStringValue(PrefUtils.displayAddress, nurseDetails.displayAddress);
    PrefUtils.setStringValue(PrefUtils.addressLineOne, nurseDetails.address1);
    PrefUtils.setStringValue(PrefUtils.addressLineTwo, nurseDetails.address2);
    PrefUtils.setStringValue(PrefUtils.phoneNumber, nurseDetails.phoneNumber);
    PrefUtils.setStringValue(PrefUtils.zipCode, nurseDetails.zipCode);
    PrefUtils.setStringValue(PrefUtils.cityName, nurseDetails.cityName);
    PrefUtils.setStringValue(PrefUtils.stateName, nurseDetails.stateName);
    if(from.compareTo("FromLogin") == 0){
      PrefUtils.setBoolValue(PrefUtils.isFirstTimeLogin, nurseDetails.isFirstTimeLogin);
      PrefUtils.setIntValue(PrefUtils.visitId, 0);
      PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
    }
  }

  static void getNurseDataFromPref() async {
    await getValueFor(PrefUtils.nurseId);
    await getValueFor(PrefUtils.isLoggedIn);
    await getValueFor(PrefUtils.isFirstTimeLogin);
    await getValueFor(PrefUtils.email);
    await getValueFor(PrefUtils.firstName);
    await getValueFor(PrefUtils.lastName);
    await getValueFor(PrefUtils.MiddleName);
    await getValueFor(PrefUtils.addressLineOne);
    await getValueFor(PrefUtils.addressLineTwo);
    await getValueFor(PrefUtils.zipCode);
    await getValueFor(PrefUtils.Gender);
    await getValueFor(PrefUtils.phoneNumber);
    await getValueFor(PrefUtils.DateOfBirth);
    await getValueFor(PrefUtils.NurseImage);
    await getValueFor(PrefUtils.stateName);
    await getValueFor(PrefUtils.cityName);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
