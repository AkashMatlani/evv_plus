import 'dart:async';

import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/CarePlanDetailsScreen.dart';
import 'package:evv_plus/Ui/ClientPatientSignScreen.dart';
import 'package:evv_plus/Ui/ClientPatientVoiceSignatureScreen.dart';
import 'package:evv_plus/Ui/UnableToSignInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../GeneralUtils/ColorExtension.dart';

enum visitVerification { patient, voice }


class VerificationMenuScreen extends StatefulWidget {
  CompletedNoteResponse completedNoteResponse;

  VerificationMenuScreen(this.completedNoteResponse);

  bool isbool=true;

  @override
  _VerificationMenuScreenState createState() => _VerificationMenuScreenState();
}

class _VerificationMenuScreenState extends State<VerificationMenuScreen> {
  List<String> menuNameList;
  List<String> menuIconList;

  AuthViewModel _nurseViewModel = AuthViewModel();
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();

  @override
  void initState() {
    super.initState();
    menuNameList = [];
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: HexColor("#efefef"),
          ),
          SizedBox(height: 10),
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
                    if (( Utils.isPatientSignCompleted &&  Utils.isPatientVoiceCompleted) ||Utils.unableToSignReason) {
                      visitUpdateTRue(context);
                    } else {
                      ToastUtils.showToast(context, "Please add patient signature and voice or provide sign reason", Colors.red);
                    }
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
        if (position == 0) {

          Utils.navigateToScreen(
              context,
              ClientPatientSignScreen(
                  widget.completedNoteResponse,visitVerification.patient,widget.isbool));
        } else if (position == 1) {
          Utils.navigateToScreen(
              context,
              ClientPatientVoiceSignatureScreen(
                  widget.completedNoteResponse, visitVerification.voice));
        } else if (position == 2) {
          Utils.navigateToScreen(
              context, UnableToSignInScreen(widget.completedNoteResponse));
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

  /* _showDialog(BuildContext context) {
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
  }*/

  _showDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: SvgPicture.asset(MyImage.ic_thumbUp),
            ),
            SizedBox(height: 10),
            Text(LabelStr.lblSuccess,
                style: AppTheme.mediumSFTextStyle()
                    .copyWith(color: HexColor("#3d3d3d"), fontSize: 20)),
            Text(LabelStr.lblCompleteEvv,
                style: AppTheme.regularSFTextStyle()
                    .copyWith(color: HexColor("#3d3d3d"))),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(LabelStr.lblOk,
              style: AppTheme.boldSFTextStyle()
                  .copyWith(color: Colors.blue, fontSize: 18)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Discard");
            getVisitDetails(widget.completedNoteResponse.id.toString());
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData(
                dialogBackgroundColor: Colors.white,
                dialogTheme: DialogTheme(backgroundColor: Colors.black)),
            child: alert);
      },
    );
  }

  void visitUpdateTRue(BuildContext context) {
    Utils.showLoader(true, context);
    _nurseViewModel.getUpdatedVisitTrue(
        widget.completedNoteResponse.nurseId.toString(),
        widget.completedNoteResponse.patientId.toString(),
        widget.completedNoteResponse.id.toString(), (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          Utils.isPatientVoiceCompleted=false;
          Utils.isPatientSignCompleted=false;
          Utils.unableToSignReason=false;
        });
        PrefUtils.setIntValue(PrefUtils.visitId, 0);
        _showDialog(context);
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  getVisitDetails(String visitId) {
    _scheduleViewModel.getVisitDetailsAPICall(visitId, (isSuccess, message){
      if(isSuccess){
        Utils.navigateToScreen(context, CarePlanDetailsScreen(_scheduleViewModel.schedulleDetails, false, "VisitComplete"));
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
