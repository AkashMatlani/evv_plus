import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CommentFilterResponse.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientCommentScreen extends StatefulWidget {
  PatientCommentScreen(this.isSearchVisible, this.scheduleDetailInfo);
  ScheduleInfoResponse scheduleDetailInfo;
  bool isSearchVisible;

  @override
  _PatientCommentScreenState createState() => _PatientCommentScreenState();
}

class _PatientCommentScreenState extends State<PatientCommentScreen> {
  var _commentController = TextEditingController();
  var _searchController = TextEditingController();
  String nurseId="", nurseName="", patientName="", patientId="";
  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  List<CommentFilterResponse> _filterList = [];

  @override
  void initState() {
    super.initState();
    patientName = widget.scheduleDetailInfo.firstName+" "+
        widget.scheduleDetailInfo.middleName+" "+
        widget.scheduleDetailInfo.lastName;
    patientId = widget.scheduleDetailInfo.patientId.toString();

    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      nurseId = prefs.getInt(PrefUtils.nurseId).toString();
      nurseName = prefs.getString(PrefUtils.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
    child: ConstrainedBox(
    constraints: BoxConstraints(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isSearchVisible ? Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("#eaeff2")),
                child: Stack(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 50),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LabelStr.lblSearchPatientOrPlan,
                          ),
                          keyboardType: TextInputType.text,
                          controller: _searchController,
                        )),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          checkConnection().then((isConnected) {
                            if(isConnected){
                              _getFilterItemList(context, _searchController.text.toString());
                            } else {
                              ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
                            }
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(MyImage.ic_search),
                        ),
                      ),
                      right: 5,
                      top: 10,
                    ),
                    _filterList.length == 0 ? Container() : _searchListView()
                  ],
                ),
              ) : Container(),
              SizedBox(height: 15),
              Text(LabelStr.lblPatientOrPlan,
                  style: AppTheme.semiBoldSFTextStyle()
                      .copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 5),
              Text(patientName,
                  style: AppTheme.regularSFTextStyle()
                      .copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 20),
              Text(LabelStr.lblNurseName,
                  style: AppTheme.semiBoldSFTextStyle()
                      .copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 5),
              Text(nurseName,
                  style: AppTheme.regularSFTextStyle()
                      .copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 20),
              multilineTextFieldFor(
                  "Comment here...", _commentController, 140.0),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 50,
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
                            /* ToastUtils.showToast(context,
                                "Click on submit", Colors.red);*/
                            sendCommentApi();
                          } else {
                            ToastUtils.showToast(
                                context, LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: HexColor("#c1def8")),
                    child: TextButton(
                      child: Text(LabelStr.lblCancel,
                          style: AppTheme.boldSFTextStyle().copyWith(
                              fontSize: 18, color: HexColor("#2b91eb"))),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  void sendCommentApi() {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.commentApiCall("1", widget.scheduleDetailInfo.patientId.toString(),
        nurseId, _commentController.text, widget.scheduleDetailInfo.carePlanName, (isSuccess, message){
          Utils.showLoader(false, context);
          if(isSuccess){
            ToastUtils.showToast(context, message, Colors.green);
            Timer(
              Duration(seconds: 2),
                  () => Navigator.of(context).pop(),
            );
          } else {
            ToastUtils.showToast(context, message, Colors.red);
          }
        });
  }

  void _getFilterItemList(BuildContext context, String patientName) {
    _nurseVisitViewModel.getFilterListAPICall("1", patientName, "", (isSuccess, message){
      if(isSuccess){
        _filterList = [];
        setState(() {
          _filterList = _nurseVisitViewModel.commentFilterList;
        });
      } else {
        _filterList = [];
        setState(() {
          patientName = widget.scheduleDetailInfo.firstName+" "+
              widget.scheduleDetailInfo.middleName+" "+
              widget.scheduleDetailInfo.lastName;
        });
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  _searchListView() {
    return Container(
      margin: EdgeInsets.only(right: 50, bottom: 5),
      color: HexColor("#eaeff2"),
      child: ListView.builder(
        itemCount: _filterList.length,
        itemBuilder: (context, int index) {
          return Container(
            decoration: new BoxDecoration(
                color: HexColor("#eaeff2"),
                border: new Border(
                    bottom: new BorderSide(
                        color: Colors.grey,
                        width: 0.5
                    )
                )
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  patientName = _filterList[index].patientName;
                  patientId = _filterList[index].patientId.toString();
                });
                checkConnection().then((isConnected) {
                  if (isConnected) {
                    sendCommentApi();
                  } else {
                    ToastUtils.showToast(
                        context, LabelStr.connectionError, Colors.red);
                  }
                });
              },
              title: Text(_filterList[index].patientName,
                  style: new TextStyle(fontSize: 18.0)),
            ),
          );
        },
      ),
    );
  }
}
