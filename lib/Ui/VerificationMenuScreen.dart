import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/ClientPatientSignScreen.dart';
import 'package:evv_plus/Ui/ClientPatientVoiceSignatureScreen.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:evv_plus/Ui/UnableToSignInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../GeneralUtils/ColorExtension.dart';

class VerificationMenuScreen extends StatefulWidget {
  @override
  _VerificationMenuScreenState createState() => _VerificationMenuScreenState();
}

class _VerificationMenuScreenState extends State<VerificationMenuScreen> {
  List<String> menuNameList;
  List<String> menuIconList;

  @override
  void initState() {
    super.initState();
    menuNameList = List<String>();
    menuNameList = [
      LabelStr.lblPatientSign,
      LabelStr.lblPatientVoice,
      LabelStr.lblSignReason
    ];

    menuIconList = List<String>();
    menuIconList = [
      MyImage.ic_medical,
      MyImage.ic_voice_chat,
      MyImage.ic_document
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Text(LabelStr.lblVisitVerification,
              style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
        ),
        backgroundColor: Colors.white10,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            ToastUtils.showToast(context, "Back press", Colors.blueAccent);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuNameList.length,
              itemBuilder: (context, position) {
                return listRowItems(context, position);
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              child: Text(LabelStr.lblSubmit,
                  style: AppTheme.boldSFTextStyle()
                      .copyWith(fontSize: 18, color: Colors.white)),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                checkConnection().then((isConnected) {
                  if (isConnected) {
                    _showDialog(context);
                  } else {
                    ToastUtils.showToast(
                        context, LabelStr.connectionError, Colors.red);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        // ToastUtils.showToast(context, menuNameList[position], Colors.blueAccent);
        if (position == 0) {
          Utils.navigateToScreen(context, ClientPatientSignScreen());
        } else if (position == 1) {
          Utils.navigateToScreen(context, ClientPatientVoiceSignatureScreen());
        } else if (position == 2) {
          Utils.navigateToScreen(context, UnableToSignInScreen());
        }
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: HexColor("#E9E9E9"),
              width: 0.5,
            )),
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero),
                  color: HexColor("#c7e4fd"),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(menuIconList[position]),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(menuNameList[position],
                      style:
                          AppTheme.mediumSFTextStyle().copyWith(fontSize: 18))),
              SizedBox(width: 10),
              Card(
                margin: EdgeInsets.only(right: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                  child: SvgPicture.asset(MyImage.ic_forword_blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(MyImage.ic_thumbUp),
                    ),
                    SizedBox(height: 10),
                    Text("Success",
                        style: AppTheme.mediumSFTextStyle().copyWith(
                            color: HexColor("#3d3d3d"), fontSize: 20)),
                    Text("Complete EVV",
                        style: AppTheme.regularSFTextStyle()
                            .copyWith(color: HexColor("#3d3d3d"))),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor("#f5f5f5"),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          child: Text(LabelStr.lblOk,
                              style: AppTheme.mediumSFTextStyle()
                                  .copyWith(fontSize: 20)),
                          onPressed: () {
                            //Navigator.of(context).pop();
                            Utils.navigateReplaceToScreen(context, ScheduleScreen());
                          }),
                    )
                  ],
                )),
          );
        });
  }
}
