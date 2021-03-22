
import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Ui/ForgotPwdScreen.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChangePwdScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  var _authViewModel = AuthViewModel();
  var email,firstName,lastName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(MyImage.loginBgImage, fit: BoxFit.fill),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width*0.15,
                      child: SvgPicture.asset(MyImage.appLogoV)
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(LabelStr.lblLogIn,
                        style: AppTheme.boldSFTextStyle().copyWith(fontSize: 28)),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 30),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: textFieldFor(
                          LabelStr.lblEmailId, _emailController,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          perfixIcon: Container(
                            padding: EdgeInsets.all(13),
                            child: SvgPicture.asset(MyImage.ic_email),
                          ),
                          keyboardType: TextInputType.emailAddress)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: textFieldFor(
                          LabelStr.lblPassword, _passwordController,
                          autocorrect: false,
                          obscure: true,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                          perfixIcon: Container(
                            padding: EdgeInsets.all(13),
                            child: SvgPicture.asset(MyImage.ic_password),
                          ),
                          keyboardType: TextInputType.text)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          HexColor("#1785e9"),
                          HexColor("#83cff2")
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextButton(
                      child: Text(LabelStr.lblLogIn,
                          style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            nurseLogIn(context);
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () => {
                      Utils.navigateToScreen(context, ForgotPwdScreen())
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text(LabelStr.lblForgotPwd,
                            style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.black26).copyWith(decoration: TextDecoration.underline))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  nurseLogIn(BuildContext context) {
    var _email = _emailController.text.trim();
    var _password = _passwordController.text.trim();
    Utils.showLoader(true, context);
    _authViewModel.logInResult(_email, _password, (isValid, message) {
      Utils.showLoader(false, context);
      if(isValid){
        ToastUtils.showToast(context, "Login Successful", Colors.green);

        Timer(
          Duration(seconds: 2), () {
          SharedPreferences.getInstance().then((prefs) async {
            PrefUtils.getNurseDataFromPref();
             email = prefs.getString(PrefUtils.email);
             firstName = prefs.getString(PrefUtils.firstName);
             lastName= prefs.getString(PrefUtils.lastName);
            if(prefs.containsKey(PrefUtils.isFirstTimeLogin) && prefs.getBool(PrefUtils.isFirstTimeLogin)){
              Utils.navigateReplaceToScreen(context, ScheduleScreen());
            } else {
              Utils.navigateToScreen(context, ChangePwdScreen(LabelStr.lblNewPwd));
            }
          });
          },
        );
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
