import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'ColorExtension.dart';

class AppTheme {
  static TextStyle headerTextStyle() {
    return TextStyle(
        fontFamily: MyFont.sfPro,
        fontSize: 18,
        color: Colors.black);
  }

  static TextStyle textFieldHintTextStyle() {
    return TextStyle(
        fontFamily: MyFont.sfPro,
        fontSize: 16,
        color: MyColor.hintTextColor());
  }

  static TextStyle normalTextStyle() {
    return TextStyle(
        fontFamily: MyFont.sfPro,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: MyColor.normalTextColor());
  }
}

class MyFont {
  static const sfPro = "SFPro";
}

class MyImage {
  static const splashBgImage = "assets/bg_image/splash_bg.png";
  static const loginBgImage = "assets/bg_image/login_bg.png";

  static const appLogoH = "assets/icons/app_logo_horizontal.svg";
  static const appLogoV = "assets/icons/app_logo_vertical.svg";
  static const ic_email = "assets/icons/ic_email.svg";
  static const ic_password = "assets/icons/ic_password.svg";
}

class MyColor {
  static Color hintTextColor() {
    return HexColor("#646464");
  }

  static Color normalTextColor() {
    return HexColor("#262626");
  }

  static Color textFieldBorderColor() {
    return HexColor("#D2D2D2");
  }

  static Color backgroundColor() {
    return HexColor("#F8F8F7");
  }
}

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

class ValidationResult {
  var message = "";
  var isValid = false;

  ValidationResult(this.isValid, this.message);
}