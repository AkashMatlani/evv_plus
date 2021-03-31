import 'dart:async';

import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ClientPatientVoiceSignatureScreen.dart';
import 'ScheduleScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      (){
        SharedPreferences.getInstance().then((prefs) async {
          PrefUtils.getNurseDataFromPref();
          if(prefs.containsKey(PrefUtils.isLoggedIn) && prefs.getBool(PrefUtils.isLoggedIn)){
            if(prefs.containsKey(PrefUtils.visitId) && prefs.getInt(PrefUtils.visitId) == 0){
              Utils.navigateReplaceToScreen(context, ScheduleScreen());
            } else {
              getVisitDetails(prefs.getInt(PrefUtils.visitId));
            }
          } else {
            Utils.navigateReplaceToScreen(context, LoginScreen());
          }
        });
      },
    );
    //print("Splash Done!"))
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(MyImage.splashBgImage, fit: BoxFit.fill),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width*0.2,
              child: SvgPicture.asset(MyImage.appLogoH)
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getVisitDetails(int visitId) {
    _scheduleViewModel.getVisitDetailsAPICall(visitId.toString(), (isSuccess, message){
      if(isSuccess){
        Utils.navigateReplaceToScreen(context, CustomVisitMenuScreen(_scheduleViewModel.schedulleDetails));
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
