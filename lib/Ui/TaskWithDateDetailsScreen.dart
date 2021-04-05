import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:evv_plus/Ui/VerificationMenuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TaskWithDateDetailsScreen extends StatefulWidget {
  TaskWithDateDetailsScreen(this._visitNoteDetails);
  CompletedNoteResponse _visitNoteDetails;

  @override
  _TaskWithDateDetailsScreenState createState() => _TaskWithDateDetailsScreenState();
}

class _TaskWithDateDetailsScreenState extends State<TaskWithDateDetailsScreen> {
  var _clientNameController = TextEditingController();
  var _clinicianNameController = TextEditingController();
  var _checkInDateController = TextEditingController();
  var _checkInTimeController = TextEditingController();
  var _checkOutDateController = TextEditingController();
  var _checkOutTimeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  double blockSizeVertical;
  double screenHeight;
  int visitId;

  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();

  @override
  void initState() {
    super.initState();
    _clientNameController.addListener(_handleText(1));
    _clinicianNameController.addListener(_handleText(2));
    _checkInTimeController.addListener(_handleText(3));
    _checkInDateController.addListener(_handleText(4));
    _checkOutTimeController.addListener(_handleText(5));
    _checkOutDateController.addListener(_handleText(6));

    getVisitId();
  }

  void getVisitId() async {
    visitId = await PrefUtils.getValueFor(PrefUtils.visitId);
  }

  _handleText(int flag){
    if(flag == 1){
      _clientNameController.text = widget._visitNoteDetails.clientName;
    } else if(flag == 2){
      _clinicianNameController.text = widget._visitNoteDetails.clinicianName;
    } else if(flag == 3){
      _checkInTimeController.text = Utils.convertTime(widget._visitNoteDetails.checkInTime.substring(0, 5));
    } else if(flag == 4){
      _checkInDateController.text = Utils.convertDate(widget._visitNoteDetails.checkInDate, DateFormat("MM/dd/yy"));
    } else if(flag == 5){
      _checkOutTimeController.text = Utils.convertTime(widget._visitNoteDetails.checkOutTime.substring(0, 5));
    } else {
      _checkOutDateController.text = Utils.convertDate(widget._visitNoteDetails.checkOutDate, DateFormat("MM/dd/yy"));
    }
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    blockSizeVertical = screenHeight / 100;

    return WillPopScope(onWillPop: (){
      _showDialog(context);
    },
    child: Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text("Task "+Utils.convertDate(widget._visitNoteDetails.checkInDate, DateFormat("MM/dd/yy")),
                style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _showDialog(context);
            },
          )),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: HexColor("#efefef"),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  textFieldFor(
                      LabelStr.lblClientName,
                      _clientNameController,
                      readOnly: true,
                      onEditingComplete: (){
                        _clientNameController.text = _clientNameController.text = widget._visitNoteDetails.clientName;
                      }),
                  SizedBox(height: 12),
                  textFieldFor(
                      LabelStr.lblClinicianName, _clinicianNameController, readOnly: true),
                  SizedBox(height: 12),
                  Text(LabelStr.lblDateNote,
                      style: AppTheme.semiBoldSFTextStyle()),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: HexColor("#d2d2d2"), width: 1),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LabelStr.lblCheckIn,
                            style: AppTheme.semiBoldSFTextStyle().copyWith(
                                fontSize: 14, color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                                flex: 1,child:Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: textFieldFor(
                                  "09/03/2020", _checkInDateController,
                                  suffixIcon: Container(
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 5,
                                        right: 5),
                                    child:
                                    SvgPicture.asset(MyImage.ic_calender),
                                  ),
                                  readOnly: true),
                            )),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.02),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: textFieldFor(
                                  "11:30 am", _checkInTimeController,
                                  suffixIcon: Container(
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 5,
                                        right: 5),
                                    child: SvgPicture.asset(MyImage.ic_clock),
                                  ),
                                  readOnly: true),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: HexColor("#d2d2d2"), width: 1),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LabelStr.lblCheckout,
                            style: AppTheme.semiBoldSFTextStyle().copyWith(
                                fontSize: 14, color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: textFieldFor(
                                    "09/03/2020", _checkOutDateController,
                                    suffixIcon: Container(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 5,
                                          right: 5),
                                      child:
                                      SvgPicture.asset(MyImage.ic_calender),
                                    ),
                                    readOnly: true),
                              ),
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.02),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: textFieldFor(
                                  "11:30 am", _checkOutTimeController,
                                  suffixIcon: Container(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 5,
                                          right: 5),
                                      child:
                                      SvgPicture.asset(MyImage.ic_clock)),
                                  readOnly: true),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextButton(
                      child: Text(LabelStr.lblCollectSign,
                          style: AppTheme.boldSFTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            Utils.navigateToScreen(context, VerificationMenuScreen(widget._visitNoteDetails));
                          } else {
                            ToastUtils.showToast(
                                context, LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: HexColor("#c1def8")),
                    child: TextButton(
                      child: Text(LabelStr.lblCancelVerification,
                          style: AppTheme.boldSFTextStyle().copyWith(
                              fontSize: 18, color: HexColor("#2b91eb"))),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _showDialog(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  _showDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
                height:blockSizeVertical*20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(LabelStr.lbCancelVisit, style: AppTheme.headerTextStyle().copyWith(fontSize: 20)),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 10, bottom: 0, top: 10),
                          child: Text(
                            LabelStr.lblAskForCancel,
                            style: AppTheme.mediumSFTextStyle().copyWith(color: HexColor("#3d3d3d")),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor("#f5f5f5"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 51,
                        child: Row(
                          children: [
                            Container(
                              height: 51,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.4,
                              child: TextButton(
                                  child: Text(LabelStr.lblNo, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20,color: HexColor("#878787"))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ),
                            SizedBox(width: 1),
                            Container(
                              width: 1,
                              height: 51,
                              color: HexColor("#f5f5f5"),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 51,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: TextButton(
                                      child: Text(LabelStr.lblYes, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20, color: HexColor("#1a87e9"))),
                                      onPressed: () {
                                        cancelVisit(true);
                                      }),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }

  void cancelVisit(bool isFromDialog) {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.cancelRunningVisitApiCall(visitId.toString(), (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        if(isFromDialog) {
          Navigator.of(context).pop();
        }
        PrefUtils.setIntValue(PrefUtils.visitId, 0);
        Utils.navigateWithClearState(context, ScheduleScreen());
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _clinicianNameController.dispose();
    _checkInDateController.dispose();
    _checkInTimeController.dispose();
    _checkOutTimeController.dispose();
    _checkOutDateController.dispose();
    super.dispose();
  }
}
