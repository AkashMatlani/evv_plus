import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangePwdScreen extends StatefulWidget {
  ChangePwdScreen(this.title);
  String title;

  @override
  _ChangePwdScreenState createState() => _ChangePwdScreenState();
}

class _ChangePwdScreenState extends State<ChangePwdScreen> {

  var _newPwdController = TextEditingController();
  var _confirmPwdController = TextEditingController();

  var authViewModel = AuthViewModel();
  String nurseId = "", currentPwd = "";

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 100), () {
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getNurseDataFromPref();
        nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        currentPwd = prefs.getString(PrefUtils.password);
      });
    });
  }

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
                children: [
                  Container(
                    child: Text(widget.title,
                        style: AppTheme.boldSFTextStyle().copyWith(fontSize: 28)),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 30),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: textFieldFor(
                          LabelStr.lblNewPwd, _newPwdController,
                          autocorrect: false,
                          obscure: true,
                          textInputAction: TextInputAction.next,
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
                      height: 55,
                      child: textFieldFor(
                          LabelStr.lblConfirmPwd, _confirmPwdController,
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
                      child: Text(LabelStr.lblUpdatePwd,
                          style: AppTheme.boldSFTextStyle().copyWith(color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            updatePassword();
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  updatePassword() {
    var newPwd = _newPwdController.text.trim();
    var confirmPwd = _confirmPwdController.text.trim();

    Utils.showLoader(true, context);
    authViewModel.updatePwdResult(nurseId, currentPwd, newPwd, confirmPwd, (isValid, message) {
      Utils.showLoader(false, context);
      if (isValid) {
        Utils.navigateReplaceToScreen(context, ScheduleScreen());
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
