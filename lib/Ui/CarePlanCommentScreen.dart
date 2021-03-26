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

class CarePlanCommentScreen extends StatefulWidget {
  CarePlanCommentScreen(this.isSearchVisible, this.scheduleDetailInfo);
  ScheduleInfoResponse scheduleDetailInfo;
  bool isSearchVisible;


  @override
  _CarePlanCommentScreenState createState() => _CarePlanCommentScreenState();
}

class _CarePlanCommentScreenState extends State<CarePlanCommentScreen> {
  var _commentController = TextEditingController();
  var _searchController = TextEditingController();
  String nurseId="", nurseName="", planName="", patientId="";
  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  List<CommentFilterResponse> _filterList = [];

  @override
  void initState() {
    super.initState();
    planName = widget.scheduleDetailInfo.carePlanName;
    Timer(Duration(milliseconds: 100), (){
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getNurseDataFromPref();
        nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        setState(() {
          nurseName = prefs.getString(PrefUtils.fullName);
        });
      });
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
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("#eaeff2")),
                child: Stack(
                  children: [
                    Container(
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
                                if(_searchController.text.trim().toString().isNotEmpty){
                                  checkConnection().then((isConnected) {
                                    if(isConnected){
                                      _getFilterItemList(context, _searchController.text.toString());
                                    } else {
                                      ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
                                    }
                                  });
                                }
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
                        ],
                      ),
                    ),
                    Container(
                      child: _filterList.length == 0 ? Container() : _searchListView(),
                    )
                  ],
                ),
              ) : Container(),
              SizedBox(height: 15),
              Text(LabelStr.lblPatientOrPlan,
                  style: AppTheme.semiBoldSFTextStyle()
                      .copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 5),
              Text(planName,
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
                            /*ToastUtils.showToast(
                                context, "Click on submit", Colors.red);*/
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
                  ),
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
    _nurseVisitViewModel.commentApiCall("2", widget.scheduleDetailInfo.patientId.toString(),
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

  void _getFilterItemList(BuildContext context, String searchStr) {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.getFilterListAPICall("2", "", searchStr, (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        setState(() {
          _filterList = _nurseVisitViewModel.commentFilterList;
        });
      } else {
        setState(() {
          planName = widget.scheduleDetailInfo.carePlanName;
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
        shrinkWrap: true,
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
                  planName = _filterList[index].carePlanName;
                  patientId = _filterList[index].patientId.toString();
                  _searchController.text = planName;
                  _filterList = [];
                });
              },
              title: Text(_filterList[index].carePlanName,
                  style: new TextStyle(fontSize: 18.0)),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
