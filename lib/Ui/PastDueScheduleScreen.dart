import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
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

import 'CarePlanDetailsScreen.dart';

class PastDueScheduleScreen extends StatefulWidget {
  @override
  _PastDueScheduleScreenState createState() => _PastDueScheduleScreenState();
}

class _PastDueScheduleScreenState extends State<PastDueScheduleScreen> {
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  List<ScheduleInfoResponse> _pastVisitList = [];
  List<ScheduleInfoResponse> _filterList = [];
  bool isLoading = true;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      String nurseId = prefs.getInt(PrefUtils.nurseId).toString();
      Timer(
        Duration(milliseconds: 100),
        () {
          checkConnection().then((isConnected) {
            if (isConnected) {
              _getPastDueList(nurseId);
            } else {
              ToastUtils.showToast(
                  context, LabelStr.connectionError, Colors.red);
            }
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pastVisitList.length == 0
          ? emptyListView()
          : SingleChildScrollView(child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10),
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
                        hintText: "Search patient name/care plan",
                      ),
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _filterList = [];
                            _filterList = _pastVisitList;
                          }
                        });
                      },
                    )),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      String filterKey = searchController.text.toString();
                      if (filterKey.isNotEmpty) {
                        _filterList = [];
                        for (var i = 0; i < _pastVisitList.length; i++) {
                          String name = _pastVisitList[i].firstName +
                              " " +
                              _pastVisitList[i].lastName;
                          if (name.contains(filterKey) ||
                              _pastVisitList[i]
                                  .carePlanName
                                  .contains(filterKey)) {
                            _filterList.add(_pastVisitList[i]);
                          }
                        }
                      } else {
                        _filterList = [];
                        _filterList = _pastVisitList;
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
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: _filterList.length,
            itemBuilder: (context, position) {
              return listRowItems(context, position);
            },
          )
        ],
      )),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      child: isLoading
          ? Container()
          : Text(LabelStr.lblNoData,
              style: AppTheme.semiBoldSFTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        Utils.navigateToScreen(
            context, CarePlanDetailsScreen(_filterList[position], false, "SchedulePastDue"));
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: HexColor("#E9E9E9"),
              width: 0.5,
            )),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                child: _filterList[position].profilePhotoPath.isNotEmpty ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: false,
                      imageUrl: _filterList[position].profilePhotoPath,
                      placeholder: (context, url) => Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => defaultUserProfile(),
                    ),
                  ),
                ) : defaultUserProfile(),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        _filterList[position].firstName +
                            " " +
                            _filterList[position].lastName,
                        style:
                            AppTheme.boldSFTextStyle().copyWith(fontSize: 16)),
                    SizedBox(height: 3),
                    Text(
                        Utils.convertDate(_filterList[position].visitDate,
                            DateFormat('dd/MM/yyyy')),
                        style: AppTheme.regularSFTextStyle().copyWith(
                            fontSize: 14, color: HexColor("#969696"))),
                    SizedBox(height: 3),
                    Text(
                        Utils.convertTime(_filterList[position]
                                .timeFrom
                                .substring(0, 5)) +
                            " - " +
                            Utils.convertTime(
                                _filterList[position].timeTo.substring(0, 5)),
                        style: AppTheme.regularSFTextStyle()
                            .copyWith(fontSize: 14, color: HexColor("#969696")))
                  ],
                ),
              )),
              SizedBox(width: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: EdgeInsets.all(5),
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      margin: EdgeInsets.only(top: 3),
                      child: SvgPicture.asset(MyImage.ic_fill_circle,
                          color: HexColor("#2ab554")),
                    ),
                    SizedBox(width: 3),
                    Text(_filterList[position].carePlanName,
                        style: AppTheme.semiBoldSFTextStyle()
                            .copyWith(fontSize: 14, color: HexColor("#2ab554")))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getPastDueList(String nurseId) {
    Utils.showLoader(true, context);
    _scheduleViewModel.getPastDueListAPICall(nurseId, (isSuccess, response) {
      Utils.showLoader(false, context);
      isLoading = false;
      if (isSuccess) {
        setState(() {
          _pastVisitList = [];
          _filterList = [];
          _pastVisitList = _scheduleViewModel.pastDueScheduleList;
          _filterList = _pastVisitList;
          Utils.pastDueCount = _scheduleViewModel.pastDueVisitCount;
        });
      } else {
        setState(() {
          _pastVisitList = [];
          _filterList = [];
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
