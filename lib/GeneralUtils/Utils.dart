import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Utils {
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

  static bool isValidEmail(String email) {
    bool result = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return result;
  }

  static bool isValidPassword(String password) {
    bool result = RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,}$")
        .hasMatch(password);
    return result;
  }
}

typedef ResponseCallback(bool success, dynamic response);
