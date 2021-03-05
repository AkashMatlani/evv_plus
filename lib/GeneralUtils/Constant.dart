import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'ColorExtension.dart';

class AppTheme {
  static TextStyle headerTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_semibold,
        fontSize: 18,
        color: Colors.black);
  }

  static TextStyle textFieldHintTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_regular,
        fontSize: 16,
        color: MyColor.hintTextColor());
  }

  static TextStyle regularSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_regular,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle mediumSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_medium,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle semiBoldSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_semibold,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle boldSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_bold,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }
}

class MyFont {
  static const SFPro_medium = "SFPro_medium";
  static const SFPro_regular = "SFPro_regular";
  static const SFPro_semibold = "SFPro_semibold";
  static const SFPro_bold = "SFPro_bold";
}

class MyImage {
  static const splashBgImage = "assets/bg_image/splash_bg.png";
  static const loginBgImage = "assets/bg_image/login_bg.png";
  static const noImagePlaceholder = "assets/bg_image/no_image_placeholder.png";
  static const profilePlaceholder = "assets/bg_image/user_placeholder.svg";

  static const appLogoH = "assets/icons/app_logo_horizontal.svg";
  static const appLogoV = "assets/icons/app_logo_vertical.svg";
  static const ic_email = "assets/icons/ic_email.svg";
  static const ic_password = "assets/icons/ic_password.svg";
  static const ic_drawer = "assets/icons/ic_drawer.svg";
  static const ic_notification = "assets/icons/ic_notification.svg";
  static const ic_filter = "assets/icons/ic_filter.svg";
  static const ic_fill_circle = "assets/icons/ic_blue_circle.svg";
  static const ic_search = "assets/icons/ic_search.svg";
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