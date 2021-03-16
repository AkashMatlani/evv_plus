import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'VerificationMenuScreen.dart';

class ClientPatientSignScreen extends StatefulWidget {
  @override
  _ClientPatientSignatureScreenState createState() =>
      _ClientPatientSignatureScreenState();
}

class _ClientPatientSignatureScreenState
    extends State<ClientPatientSignScreen> {
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
              child: Text(
                LabelStr.lblclientSignature,
                style: AppTheme.boldSFTextStyle().copyWith(fontSize: 24),
              ),
            ),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Text(LabelStr.lblDone,
                      style: AppTheme.boldSFTextStyle().copyWith(
                        fontSize: 20,
                        color: HexColor("#1a87e9"),
                      )),
                ),
              )
            ],
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
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
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#e9e9e9"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60),
                            Expanded(
                              child: Container(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Shani Bhavsar',
                                        style: AppTheme.boldSFTextStyle()
                                            .copyWith(
                                                fontSize: 30,
                                                color: HexColor("#000000")))),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    LabelStr.lblSignHere,
                                    style: AppTheme.regularSFTextStyle()
                                        .copyWith(
                                            fontSize: 18,
                                            color: HexColor("#000000")),
                                  )),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor("#1785e9"),
                                  HexColor("#83cff2")
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextButton(
                              child: Text(LabelStr.lblSubmit,
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 18, color: Colors.white)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkConnection().then((isConnected) {
                                  Utils.navigateToScreen(
                                      context, VerificationMenuScreen());
                                });
                              },
                            ),
                          )),
                    ),
                  ]))));
        }));
  }
}
