
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ForgotPwdScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _ForgotPwdScreen();

}
class _ForgotPwdScreen extends State<ForgotPwdScreen> {

  var _emailController = TextEditingController();
  var _authViewModel = AuthViewModel();

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
                    child: Text(LabelStr.lblResetPwd,
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
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          HexColor("#1785e9"),
                          HexColor("#83cff2")
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      child: Text(LabelStr.lblReset,
                          style: AppTheme.boldSFTextStyle().copyWith(color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            forgotUserPwd(context);
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

  forgotUserPwd(BuildContext context) {
    var emailId = _emailController.text.trim();

    _authViewModel.forgotPwdResult(emailId, (isValid, message) {
      if (isValid) {
        _showDialog(context);
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  /*_showDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(LabelStr.checkMailLink, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 18)),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(LabelStr.lblOk, style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.blue, fontSize: 18)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Discard");
            Timer(
              Duration(milliseconds: 200),
                  () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen())),
            );
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }*/

  _showDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height*0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            LabelStr.checkMailLink,
                            style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.black, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor("#f5f5f5"),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        height: 51,
                          child: Text(LabelStr.lblOk, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                )
            ),
          );
        });
  }
}