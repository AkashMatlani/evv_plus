import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitHistoryListScreen extends StatefulWidget {
  @override
  _VisitHistoryListScreenState createState() => _VisitHistoryListScreenState();
}

class _VisitHistoryListScreenState extends State<VisitHistoryListScreen> {

  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  List<ScheduleInfoResponse> _visitHistoryList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      String nurseId = prefs.getInt(PrefUtils.nurseId).toString();
      Timer(
        Duration(milliseconds: 100), (){
        checkConnection().then((isConnected) {
          if(isConnected){
            getVisitHistoryList(nurseId);
          } else {
            ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
          }
        });
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
          margin: EdgeInsets.only(right: 20),
          child: Text(LabelStr.lblVisitHistory, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
            child: _visitHistoryList.length==0 ? emptyListView() : ListView.builder(
              itemCount: _visitHistoryList.length,
              itemBuilder: (context, position) {
                return listRowItems(context, position);
              },
            ),
          )
        ],
      ),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      child: isLoading ? Container() : Text(LabelStr.lblNoData, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  listRowItems(BuildContext context, int position) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: HexColor("#E9E9E9"),
            width: 0.5,
          )
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    useOldImageOnUrlChange: false,
                    imageUrl: _visitHistoryList[position].profilePhotoPath,
                    placeholder: (context, url) => Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(MyImage.noImagePlaceholder),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child:Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(_visitHistoryList[position].firstName+" "+_visitHistoryList[position].lastName, style: AppTheme.boldSFTextStyle().copyWith(fontSize: 16)),
                      SizedBox(height: 3),
                      Text(Utils.convertDate(_visitHistoryList[position].visitDate, DateFormat('dd/MM/yyyy')), style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696"))),
                      SizedBox(height: 3),
                      Text(Utils.convertTime(_visitHistoryList[position].timeFrom.substring(0, 5))+" - "+Utils.convertTime(_visitHistoryList[position].timeTo.substring(0, 5)), style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696")))
                    ],
                  ),
                )
            ),
            SizedBox(width: 10),
            Container(
              height: MediaQuery.of(context).size.height*0.09,
              padding: EdgeInsets.all(5),
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  Container(
                    height: 7,
                    width: 7,
                    margin: EdgeInsets.only(top: 3),
                    child: SvgPicture.asset(MyImage.ic_fill_circle, color: HexColor("#2ab554")),
                  ),
                  SizedBox(width: 3),
                  Text(_visitHistoryList[position].carePlanName, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#2ab554")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getVisitHistoryList(String nurseId) {
    Utils.showLoader(true, context);
    _scheduleViewModel.getCompletedListAPICall(nurseId, (isSuccess, response){
      Utils.showLoader(false, context);
      isLoading = false;
      if(isSuccess){
        setState(() {
          _visitHistoryList = [];
          _visitHistoryList = _scheduleViewModel.completedScheduleList;
        });
      } else{
        setState(() {
          _visitHistoryList = [];
        });
      }
    });
  }
}
