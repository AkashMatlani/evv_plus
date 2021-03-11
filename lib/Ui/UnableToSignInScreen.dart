import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/VisitVerificationScreen.dart';
import 'package:flutter/material.dart';

import 'VerificationMenuScreen.dart';

enum SingingCharacter { Physical, mental, other }

class UnableToSignInScreen extends StatefulWidget {
  @override
  _UnableToSignInScreenState createState() => _UnableToSignInScreenState();
}

class _UnableToSignInScreenState extends State<UnableToSignInScreen> {
  SingingCharacter _character = SingingCharacter.Physical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text(
              LabelStr.lblUnableToSignReason,
              style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22),
            ),
          ),
          backgroundColor: Colors.white10,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              ToastUtils.showToast(context, "Back press", Colors.blueAccent);
            },
          ),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                  ),
                  child: IntrinsicHeight(
                      child: Column(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: HexColor("#efefef"),
                        ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#e9e9e9"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                child: Text(
                                  LabelStr.lblSelectReason,
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 16, color: HexColor("#3d3d3d")),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: HexColor("#efefef"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  horizontalTitleGap: 0,
                                  title: Text(LabelStr.lblPhysicalImpairment,
                                      style: AppTheme.mediumSFTextStyle()
                                          .copyWith(
                                              fontSize: 14,
                                              color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.Physical,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  title: Text(LabelStr.lblMentalImpairment,
                                      style: AppTheme.mediumSFTextStyle()
                                          .copyWith(
                                              fontSize: 14,
                                              color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.mental,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  title: Text(LabelStr.lblOther,
                                      style: AppTheme.mediumSFTextStyle()
                                          .copyWith(
                                              fontSize: 14,
                                              color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.other,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: () {
                                        Utils.navigateToScreen(
                                            context, VisitVerificationScreen());
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor("#1785e9"),
                                              HexColor("#83cff2")
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: TextButton(
                                          child: Text(LabelStr.lblSubmit,
                                              style: AppTheme.boldSFTextStyle()
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.white)),
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            checkConnection()
                                                .then((isConnected) {
                                              Utils.navigateToScreen(context, VisitVerificationScreen());
                                            });
                                          },
                                        ),
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            HexColor("#c1def8"),
                                            HexColor("#c1def8")
                                          ]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: TextButton(
                                        child: Text(LabelStr.lblCancel,
                                            style: AppTheme.boldSFTextStyle()
                                                .copyWith(
                                                    fontSize: 18,
                                                    color:
                                                        HexColor("#2b91eb"))),
                                        onPressed: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          checkConnection()
                                              .then((isConnected) {
                                            Utils.navigateToScreen(context, VerificationMenuScreen());
                                          });
                                        },
                                      ),
                                    )),
                              ),
                            ]),
                      ),
                    ))
                  ]))));
        }));
  }
}
