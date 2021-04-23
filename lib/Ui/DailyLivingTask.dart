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
  List<String> questionList = [];
  var questionController = TextEditingController();



  @override
  void initState() {
    super.initState();
    questionList.add("Did you completed the task?");
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
    return WillPopScope(
      onWillPop: (){
        _showAlertDialog(context);
      },
      child: Scaffold(
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
              _showAlertDialog(context);
            },
          ),
          actions: [
            InkWell(
              onTap: (){
                _showAddQueDialog(context);
              },
              child: Container(
                width:35,
                height: 35,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.add_circle_outline,
                  color: MyColor.normalTextColor(),
                  size: 30.0,
                ),
              ),
            )
          ],
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
                    itemCount: questionList.length,
                    itemBuilder: (context, position) {
                      return _listViewItems(context, position);
                    },
                  ),
                ),
              )
            ],
          ),
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
                  child: Text(questionList[position], style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
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
                              submitDetails(questionList[position], Utils.answer, _commentController[position].text.toString());
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

  _showAddQueDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LabelStr.lbNewQue,
                      style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      alignment: Alignment.topLeft,
                      child: textFieldFor(LabelStr.lbNewQueHint, questionController),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextButton(
                        onPressed: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                          String question = questionController.text.trim().toString();
                          if(question.isEmpty){
                            ToastUtils.showToast(context, LabelStr.enterQuestion, Colors.red);
                          } else {
                            if(Utils.isValidQuestion(question) && question.substring(question.length-1)[0].compareTo("?") == 0){
                              setState(() {
                                questionController.text = "";
                                questionList.add(question);
                              });
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                            } else {
                              ToastUtils.showToast(context, LabelStr.invalidQuestion, Colors.red);
                            }
                          }
                        },
                        child: Text(LabelStr.lblSubmit, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
    );
  }

  _showAlertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
                height:(MediaQuery.of(context).size.height / 100)*22,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(LabelStr.lblAlert, style: AppTheme.headerTextStyle().copyWith(fontSize: 20)),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
                          child: Text(
                            LabelStr.lblBackAlert,
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
                                    Navigator.of(context, rootNavigator: true).pop('dialog');
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
                                        Utils.navigateReplaceToScreen(context, CustomVisitMenuScreen(widget._scheduleDetailInfo));
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

  submitDetails(String question, String answer, String comment) {
    String date = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(DateTime.now());
    Utils.showLoader(true, context);
    _nurseVisitViewModel.dailyLivingTaskApiCall(widget._scheduleDetailInfo.patientId.toString(),
        question, answer, comment, date, nurseId, visitId, (isSuccess, message) {
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