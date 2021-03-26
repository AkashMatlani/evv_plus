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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyLivingTask extends StatefulWidget {
  DailyLivingTask(this._scheduleDetailInfo);
  ScheduleInfoResponse _scheduleDetailInfo;

  @override
  _DailyLivingTaskState createState() => _DailyLivingTaskState();
}

class _DailyLivingTaskState extends State<DailyLivingTask> {

  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  String nurseId="", visitId="";
  int expanedBtnClick=0, prevPos=0;
  bool isRowExpaned = true;
  List<TextEditingController> _commentController = [];



  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 100), (){
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getNurseDataFromPref();
        nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        visitId = prefs.getInt(PrefUtils.visitId).toString();
        print("Visit Id :: $visitId");
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
            child: Text(LabelStr.lblDailyLivingTask, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: HexColor("#efefef"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, position) {
                    return _listViewItems(context, position);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listViewItems(BuildContext context, int position){
    _commentController.add(TextEditingController());
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: HexColor("#e9e9e9"), width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text("Did you completed the task?", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    if(position != prevPos){
                      prevPos = position;
                      expanedBtnClick=0;
                    }
                    expanedBtnClick++;
                    if(expanedBtnClick%2 == 0){
                      setState(() {
                        isRowExpaned = false;
                      });
                    } else {
                      setState(() {
                        isRowExpaned = true;
                      });
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                      child: (position == prevPos && isRowExpaned) ? SvgPicture.asset(MyImage.ic_down_arrow) : SvgPicture.asset(MyImage.ic_up_arrow),
                    ),
                  ),
                )
              ],
            ),
          ),
          (position == prevPos && isRowExpaned) ? Column(
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: HexColor("#e9e9e9"),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _radioGroup(),
                    SizedBox(height: 5),
                    multilineTextFieldFor(
                        "Comment here...",
                        _commentController[position],
                        100.0
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor("#1785e9"),
                            HexColor("#83cff2")
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextButton(
                        child: Text(LabelStr.lblSubmit,
                            style: AppTheme.mediumSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          checkConnection().then((isConnected) {
                            if (isConnected) {
                              submitDetails(Utils.answer, _commentController[position].text.toString());
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
          ) : Container(),
        ],
      ),
    );
  }

  void submitDetails(String answer, String comment) {
    String date = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(DateTime.now());
    Utils.showLoader(true, context);
    _nurseVisitViewModel.dailyLivingTaskApiCall(widget._scheduleDetailInfo.patientId.toString(),
        "Did you completed the task?", answer, comment, date, nurseId, visitId, (isSuccess, message) {
      Utils.showLoader(false, context);
      if(isSuccess){
        ToastUtils.showToast(context, message, Colors.green);
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}

class _radioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {

  String radioButtonItem = 'Yes';
  int id = 1;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'Yes';
                  id = 1;
                  Utils.answer = radioButtonItem;
                });
              },
            ),
            Text(
              'Yes',
              style: new TextStyle(fontSize: 17.0),
            ),

            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'No';
                  id = 2;
                  Utils.answer = radioButtonItem;
                });
              },
            ),
            Text(
              'No',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}