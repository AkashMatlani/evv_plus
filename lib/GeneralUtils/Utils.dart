import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Utils {
  static String answer = "Yes";

  static bool isPatientSignCompleted=false;
  static bool isPatientVoiceCompleted=false;
  static bool unableToSignReason=false;

  static void showLoader(bool show, BuildContext context) {
    if (show) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
                child: SpinKitCircle(
              color: Colors.black,
              size: 80,
            ));
          });
    } else {
      Navigator.of(context, rootNavigator: true).pop("");
    }
  }

  static Future<dynamic> navigateToScreen(
      BuildContext context, Widget screen) async {
    var value = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
    return value;
  }

  static navigateReplaceToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static logoutFromApp(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen),
      (route) => false,
    );
  }

  //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
  static bool isValidEmail(String email) {
    bool result = RegExp(r"^^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
    return result;
  }

  //r"(?=.*[A-Za-z])(?=.*\d)(?=.*[!@£$%^&*()#€])[A-Za-z\d!@£$%^&*()#€]{6,}$")
  static bool isValidPassword(String password) {
    bool result = RegExp(
            r"(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$")
        .hasMatch(password);
    return result;
  }

  static String convertDate(String date, DateFormat outputFormat){
    DateTime tempDate = new DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(date);
    return outputFormat.format(tempDate);
  }

  static String convertTime(String time){
    TimeOfDay releaseTime = TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, releaseTime.hour, releaseTime.minute);
    return DateFormat("hh:mm a").format(dt);
  }
}

typedef ResponseCallback(bool success, dynamic response);