
import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:evv_plus/Ui/TaskWithDateDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedNoteScreen extends StatefulWidget {
  CompletedNoteScreen(this._scheduleDetailInfo);
  ScheduleInfoResponse _scheduleDetailInfo;

  @override
  _CompletedNoteScreenState createState() => _CompletedNoteScreenState();
}

class _CompletedNoteScreenState extends State<CompletedNoteScreen> {
  var _clientNameController = TextEditingController();
  var _clinicianNameController = TextEditingController();
  var _signatureDateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  String visitId, nurseId;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), (){
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getNurseDataFromPref();
        nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        visitId = prefs.getInt(PrefUtils.visitId).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text(LabelStr.lblCompletedNote,
                style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: HexColor("#efefef"),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(widget._scheduleDetailInfo.carePlanName+": "+Utils.convertDate(widget._scheduleDetailInfo.visitDate, DateFormat('MM/dd/yy')),
                          style: AppTheme.semiBoldSFTextStyle()
                              .copyWith(color: HexColor("#2ab554"))),
                    ),
                    SizedBox(height: 15),
                    textFieldFor(LabelStr.lblClientName, _clientNameController),
                    SizedBox(height: 15),
                    textFieldFor(
                        LabelStr.lblClinicianName, _clinicianNameController),
                    SizedBox(height: 15),
                    textFieldFor(
                        LabelStr.lblSignatureDate, _signatureDateController,
                        suffixIcon: InkWell(
                          onTap: () {
                            _selectDate(context, _signatureDateController);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: SvgPicture.asset(MyImage.ic_calender),
                          ),
                        ),
                        readOnly: true)
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.86,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor("#1785e9"),
                            HexColor("#83cff2")
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextButton(
                        child: Text(LabelStr.lblComplete,
                            style: AppTheme.boldSFTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
                        onPressed: () {
                          validationForCompleteNoteScreen();
                        },
                      ),
                    ),
                    /*SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 45,
                        decoration: BoxDecoration(
                            color: HexColor("#c1def8"),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextButton(
                          child: Text(LabelStr.lblSaveExit,
                              style: AppTheme.boldSFTextStyle().copyWith(
                                  fontSize: 18, color: HexColor("#2b91eb"))),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            checkConnection().then((isConnected) {
                              if (isConnected) {
                                Utils.navigateToScreen(
                                    context, CustomVisitMenuScreen(ScheduleInfoResponse()));
                              } else {
                                ToastUtils.showToast(context,
                                    LabelStr.connectionError, Colors.red);
                              }
                            });
                          },
                        ),
                      ),
                    )*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: _selectedDate,
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('MM/dd/yy').format(picked);
        controller.text = formattedDate;
      });
  }

  void validationForCompleteNoteScreen() {
    if (_clientNameController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterClientName, Colors.red);
    } else if (_clinicianNameController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterClinicianName, Colors.red);
    } else if (_signatureDateController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterSignatureDate, Colors.red);
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      checkConnection().then((isConnected) {
        if (isConnected) {
          submitDetails();
        } else {
          ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
        }
      });
    }
  }

  void submitDetails() {
    Utils.showLoader(true, context);
    List<String> tempDate = _signatureDateController.text.toString().split("/");
    String formattedDate = tempDate[2]+"-"+tempDate[1]+"-"+tempDate[0];_nurseVisitViewModel.completeVisitNoteApiCall(visitId, nurseId, widget._scheduleDetailInfo.patientId.toString(),
        _clientNameController.text.toString(), _clinicianNameController.text.toString(),
        formattedDate, (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        ToastUtils.showToast(context, message, Colors.green);
        Timer(Duration(seconds: 2), (){
          Utils.navigateToScreen(context, TaskWithDateDetailsScreen(_nurseVisitViewModel.completedNoteResponse));
        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _clinicianNameController.dispose();
    _signatureDateController.dispose();
    super.dispose();
  }
}
