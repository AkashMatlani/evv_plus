import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/ChangePwdScreen.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:evv_plus/Ui/PastDueScheduleScreen.dart';
import 'package:evv_plus/Ui/TaskWithDateDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GeneralUtils/Utils.dart';
import 'CompletedScheduleScreen.dart';
import 'NotificationScreen.dart';
import 'ProfileScreen.dart';
import 'UpcommingScheduleScreen.dart';


class ScheduleScreen extends StatefulWidget {


  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int activeTabIndex = 0;
  int _selectedIndex = 0;

  String nurseName="", nurseEmailId="", nurseProfile="", nurseId = "";
  String pastDueCount, upcommingCount, completeCount;
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();

  final List<String> _menuNameList = [
    LabelStr.lblHome,
    LabelStr.lblTask,
    LabelStr.lblIcident,
    LabelStr.lblNotification,
    LabelStr.lblProfile,
    LabelStr.lblChangePwd,
    LabelStr.lblAboutUs,
  ];

  final List<String> menuIconsList = [
    MyImage.home_icon,
    MyImage.task_icon,
    MyImage.icident_icon,
    MyImage.notification_icon,
    MyImage.profile_icon,
    MyImage.ic_password,
    MyImage.about_us_icon
  ];

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Utils.navigateToScreen(context, ScheduleScreen());
    } else if (index == 1) {
      Utils.navigateToScreen(context, TaskWithDateDetailsScreen());
    } else if (index == 3) {
      Utils.navigateToScreen(context, NotificationScreen());
    } else if (index == 4) {
      Utils.navigateToScreen(context, ProfileScreen());
    } else if (index == 5) {
      Utils.navigateToScreen(context, ChangePwdScreen(LabelStr.lblChangePwd));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });

    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      nurseName = prefs.getString(PrefUtils.fullName);
      nurseEmailId = prefs.getString(PrefUtils.email);
      nurseProfile = prefs.getString(PrefUtils.NurseImage);
      nurseId = prefs.getInt(PrefUtils.nurseId).toString();

      _getScheduleCount();
    });

    setState(() {
      pastDueCount="";
      upcommingCount="";
      completeCount="";
    });
  }

  @override
  Widget build(BuildContext context) {
    var tabWidth = (MediaQuery.of(context).size.width-80) / 3;
    var tabHeight = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          alignment: Alignment.center,
          child: Text(LabelStr.lblSchedule, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
        ),
        backgroundColor: Colors.white10,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: SvgPicture.asset(MyImage.ic_notification),
            onPressed: () {
              Utils.navigateToScreen(context, NotificationScreen());
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: SvgPicture.asset(MyImage.ic_drawer),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(80),
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
        child: Container(
          width: MediaQuery.of(context).size.width*0.88,
          child: Drawer(
            child: ListView(
              shrinkWrap: true,
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(MyImage.user_placeholder, height: 100, width: 100)),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 32),
                          width: MediaQuery.of(context).size.width,
                          child: Text(nurseName,
                              style: AppTheme.semiBoldSFTextStyle()
                                  .copyWith(fontSize: 20, color: Colors.white)),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(left: 32),
                          width: MediaQuery.of(context).size.width,
                          child: Text(nurseEmailId,
                              style: AppTheme.regularSFTextStyle()
                                  .copyWith(fontSize: 14, color: Colors.white60)),
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                            topLeft: Radius.zero,
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(0)),
                        gradient: LinearGradient(
                            colors: [HexColor("#1785e9"), HexColor("#83cff2")]))),
                Container(
                  height: MediaQuery.of(context).size.height*0.55,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _menuNameList.length,
                      itemBuilder: (context, position) {
                        return _listRowItems(context, position);
                      }
                  ),
                ),
                InkWell(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                    Utils.showLoader(true, context);
                    PrefUtils.clearPref();
                    Timer(
                      Duration(seconds: 1), (){
                      Utils.showLoader(false, context);
                      Utils.logoutFromApp(context, LoginScreen());
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    margin: EdgeInsets.only(left: 25),
                    padding: EdgeInsets.fromLTRB(20,0,10,0),
                    child: Row(
                      children: [
                        SvgPicture.asset(MyImage.logout_icon),
                        SizedBox(width: 15),
                        Container( padding: EdgeInsets.fromLTRB(15,0,10,0),child: Text(LabelStr.lblLogout, style: AppTheme.sfProLightTextStyle().copyWith(color: Colors.black45)))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
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
                      )
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: (){
                        ToastUtils.showToast(context, "Selected Tab : "+activeTabIndex.toString(), Colors.blueAccent);
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
            TabBar(
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 0
                          ? _columnSelected("Past Due("+pastDueCount+")", Colors.blue, false)
                          : _columnSelected(
                          "Past Due("+pastDueCount+")", HexColor("#969696"), true)),
                ),
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 1
                          ? _columnSelected("Upcoming("+upcommingCount+")", Colors.blue, false)
                          : _columnSelected(
                          "Upcoming("+upcommingCount+")", HexColor("#969696"), true)),
                ),
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 2
                          ? _columnSelected("Completed("+completeCount+")", Colors.blue, false)
                          : _columnSelected(
                          "Completed("+completeCount+")", HexColor("#969696"), true)),
                ),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    PastDueScheduleScreen(),
                    UpcommingScheduleScreen(),
                    CompletedScheduleScreen(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _columnSelected(String tabName, Color color, bool flag) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(tabName, style: AppTheme.semiBoldSFTextStyle().copyWith(color: color)),
        ),
        SizedBox(
          height: 3,
        ),
        flag
            ? Container(height: 7)
            : Container(
                height: 7,
                width: 7,
                child: SvgPicture.asset(MyImage.ic_fill_circle),
              )
      ],
    );
  }

  _listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        Scaffold.of(context).openEndDrawer();
        _onSelected(position);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: MediaQuery.of(context).size.width*0.28),
        padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        decoration: _selectedIndex == position ? BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: HexColor("#3399eb")
        ) : BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(padding:EdgeInsets.fromLTRB(5, 0, 0, 0),child: SvgPicture.asset(menuIconsList[position], color: _selectedIndex == position ? Colors.white : Colors.black45)),
            SizedBox(width: 15),
            Container(
              padding:EdgeInsets.fromLTRB(15, 0, 5, 0),
              child: Text(_menuNameList[position], style: AppTheme.sfProLightTextStyle().copyWith(color: _selectedIndex == position ? Colors.white : Colors.black45)),
            )
          ],
        ),
      ),
    );
  }

  _getScheduleCount(){
    _scheduleViewModel.getScheduleCountAPICall(nurseId, (isSuccess, response) {
      setState(() {
        pastDueCount = _scheduleViewModel.pastDueVisitCount.toString();
        upcommingCount = _scheduleViewModel.upcommingVisitCount.toString();
        completeCount = _scheduleViewModel.completedVisitCount.toString();
      });
    });
  }
}
