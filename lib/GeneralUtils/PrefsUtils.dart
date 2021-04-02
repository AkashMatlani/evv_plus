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
  static const String addressLineOne = "com.evv_plus.addressLineOne";
  static const String addressLineTwo = "com.evv_plus.addressLineTwo";
  static const String phoneNumber = "com.evv_plus.phoneNumber";
  static const String zipCode = "com.evv_plus.zipCode";
  static const String state="com.evv_plus.state";
  static const String city="com.evv_plus.city";
  static const String stateId="com.evv_plus.stateId";
  static const String cityId="com.evv_plus.cityId";
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

    PrefUtils.setStringValue(PrefUtils.NurseImage, nurseDetails.nurseImage);
    PrefUtils.setStringValue(PrefUtils.Gender, nurseDetails.gender);
    PrefUtils.setStringValue(PrefUtils.DateOfBirth, nurseDetails.dateOfBirth);
    PrefUtils.setStringValue(PrefUtils.addressLineOne, nurseDetails.address1);
    PrefUtils.setStringValue(PrefUtils.addressLineTwo, nurseDetails.address2);
    PrefUtils.setStringValue(PrefUtils.phoneNumber, nurseDetails.phoneNumber);
    PrefUtils.setStringValue(PrefUtils.zipCode, nurseDetails.zipCode);
    PrefUtils.setIntValue(PrefUtils.stateId, nurseDetails.stateId);
    PrefUtils.setIntValue(PrefUtils.cityId, nurseDetails.cityId);
    PrefUtils.setStringValue(PrefUtils.cityName, nurseDetails.cityName);
    PrefUtils.setStringValue(PrefUtils.stateName, nurseDetails.stateName);
    if(from.compareTo("FromLogin") == 0){
      PrefUtils.setBoolValue(PrefUtils.isFirstTimeLogin, nurseDetails.isFirstTimeLogin);
      PrefUtils.setIntValue(PrefUtils.visitId, 0);
      PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
    }
  }

  static void getNurseDataFromPref() async {
    var _nurseId = await getValueFor(PrefUtils.nurseId);
    var _isLoggedIn = await getValueFor(PrefUtils.isLoggedIn);
    var _isFirstTimeLogin = await getValueFor(PrefUtils.isFirstTimeLogin);
    var _isEmail = await getValueFor(PrefUtils.email);
    var _isFirstName = await getValueFor(PrefUtils.firstName);
    var _isLastName = await getValueFor(PrefUtils.lastName);
    var addressLineOne = await getValueFor(PrefUtils.addressLineOne);
    var addressLineTwo = await getValueFor(PrefUtils.addressLineTwo);
    var phoneNumber = await getValueFor(PrefUtils.phoneNumber);
    var zipCode = await getValueFor(PrefUtils.zipCode);
    var middleName = await getValueFor(PrefUtils.MiddleName);
    var gender = await getValueFor(PrefUtils.Gender);
    var dateOfBirth = await getValueFor(PrefUtils.DateOfBirth);
    var nurseImage = await getValueFor(PrefUtils.NurseImage);
    var stateName = await getValueFor(PrefUtils.stateName);
    var cityName = await getValueFor(PrefUtils.cityName);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
