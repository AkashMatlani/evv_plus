import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/FirebaseNotificationHandler.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/AboutUsScreen.dart';
import 'package:evv_plus/Ui/ChangePwdScreen.dart';
import 'package:evv_plus/Ui/IncidentFormScreen.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:evv_plus/Ui/PastDueScheduleScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  String nurseName="", nurseEmailId="", nurseId = "";
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseNotificationHandler notificationHandler;

  final List<String> _menuNameList = [
    LabelStr.lblHome,
    LabelStr.lblIcident,
    LabelStr.lblNotification,
    LabelStr.lblProfile,
    LabelStr.lblChangePwd,
    LabelStr.lblAboutUs,
  ];

  final List<String> menuIconsList = [
    MyImage.home_icon,
    MyImage.icident_icon,
    MyImage.notification_icon,
    MyImage.profile_icon,
    MyImage.password_icon,
    MyImage.about_us_icon
  ];

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Utils.navigateToScreen(context, ScheduleScreen());
    } else if (index == 1) {
      Utils.navigateToScreen(context, IncidentFormScreen());
    } else if (index == 2) {
      Utils.navigateToScreen(context, NotificationScreen());
    } else if (index == 3) {
      Utils.navigateToScreen(context, ProfileScreen());
    } else if (index == 4) {
      Utils.navigateToScreen(context, ChangePwdScreen(LabelStr.lblChangePwd));
    }
    else if (index == 5) {
      Utils.navigateToScreen(context, AboutUsScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    imageCache.clear();
    notificationHandler = FirebaseNotificationHandler(context);
    notificationHandler.fireBaseInitialization((data){
      print("Notification Data :: "+data);
    });

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
      nurseId = prefs.getInt(PrefUtils.nurseId).toString();
      nurseName = prefs.getString(PrefUtils.fullName);
      nurseEmailId = prefs.getString(PrefUtils.email);
      setState(() {
        Utils.nurseProfile = prefs.getString(PrefUtils.NurseImage);
      });
      _getScheduleCount();
      _getNotifiationCount();
    });
  }

  @override
  void dispose() {
    notificationHandler.dispose();
    super.dispose();
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
          InkWell(
            onTap: (){
              Utils.navigateToScreen(context, NotificationScreen());
            },
            child: Stack(
              children: [
                Center(
                  child: IconButton(
                    padding: EdgeInsets.only(right: 7),
                    icon: SvgPicture.asset(MyImage.ic_notification, height: 30, width: 30),
                    onPressed: () {
                      Utils.navigateToScreen(context, NotificationScreen());
                    },
                  ),
                ),
                Utils.notificationCount == 0 ? Container() : Positioned(
                  right: 7,
                  top: 50,
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Text(Utils.notificationCount.toString(), style: AppTheme.regularSFTextStyle().copyWith(fontSize: 8, color: Colors.white)),
                  ),
                )
              ],
            ),
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
                          child: Container(
                            height: 80,
                            width: 80,
                            child: Utils.nurseProfile.isNotEmpty ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(Utils.nurseProfile, fit: BoxFit.cover,
                                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
                                },
                              )) : defaultUserProfile(),
                          )
                        ),
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
                    Utils.showLoader(true, context);
                    PrefUtils.clearPref();
                    Timer(
                      Duration(seconds: 1), (){
                      Utils.showLoader(false, context);
                      Utils.navigateWithClearState(context, LoginScreen());
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    margin: EdgeInsets.only(left: 25),
                    padding: EdgeInsets.fromLTRB(5,0,10,0),
                    child: Row(
                      children: [
                        SvgPicture.asset(MyImage.logout_icon,height: 20,width: 20,),
                        SizedBox(width: 15),
                        Container( padding: EdgeInsets.fromLTRB(20,0,10,0),child: Text(LabelStr.lblLogout, style: AppTheme.sfProLightTextStyle().copyWith(color: Colors.black45)))
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
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 0
                          ? _columnSelected("Past Due("+Utils.pastDueCount.toString()+")", Colors.blue, false)
                          : _columnSelected(
                          "Past Due("+Utils.pastDueCount.toString()+")", HexColor("#969696"), true)),
                ),
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 1
                          ? _columnSelected("Upcoming("+Utils.upcommingCountCount.toString()+")", Colors.blue, false)
                          : _columnSelected(
                          "Upcoming("+Utils.upcommingCountCount.toString()+")", HexColor("#969696"), true)),
                ),
                Tab(
                  child: Container(
                      width: tabWidth,
                      height: tabHeight,
                      child: activeTabIndex == 2
                          ? _columnSelected("Completed("+Utils.completedCount.toString()+")", Colors.blue, false)
                          : _columnSelected(
                          "Completed("+Utils.completedCount.toString()+")", HexColor("#969696"), true)),
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
          child: Text(tabName, style: AppTheme.semiBoldSFTextStyle().copyWith(color: color, fontSize: 15)),
        ),
        flag
            ? Expanded(child: Container(height: 7))
            : Expanded(child: Container(
          height: 7,
          width: 7,
          child: SvgPicture.asset(MyImage.ic_fill_circle),
        ))
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
        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5, right: MediaQuery.of(context).size.width*0.28),
        padding: EdgeInsets.all(10),
        decoration: _selectedIndex == position ? BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: HexColor("#3399eb")
        ) : BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(padding:EdgeInsets.fromLTRB(5, 0, 0, 0),child: SvgPicture.asset(menuIconsList[position], color: _selectedIndex == position ? Colors.white : Colors.black45),),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                padding:EdgeInsets.fromLTRB(20, 0, 5, 0),
                child: Text(_menuNameList[position], style: AppTheme.sfProLightTextStyle().copyWith(color: _selectedIndex == position ? Colors.white : Colors.black45),textAlign: TextAlign.justify,),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getScheduleCount(){
    _scheduleViewModel.getScheduleCountAPICall(nurseId, (isSuccess, response) {
      if(isSuccess){
        setState(() {
          Utils.pastDueCount = _scheduleViewModel.pastDueVisitCount;
          Utils.upcommingCountCount = _scheduleViewModel.upcommingVisitCount;
          Utils.completedCount = _scheduleViewModel.completedVisitCount;
        });
      } else{
        setState(() {
          Utils.pastDueCount = 0;
          Utils.upcommingCountCount = 0;
          Utils.completedCount = 0;
        });
      }
    });

    _firebaseMessaging.getToken().then((token){
      updateDeviceTokenApi(token);
    });
  }

  void updateDeviceTokenApi(String token) {
    _scheduleViewModel.updateDeviceTokenAPICall(nurseId, token, (isSuccess, message){});
  }

  _getNotifiationCount() {
    _nurseVisitViewModel.getNotificationCountApiCall(nurseId, (isSuccess, message) {
      if(isSuccess){
        setState(() {
          Utils.notificationCount = _nurseVisitViewModel.count;
        });
      } else {
        setState(() {
          Utils.notificationCount = 0;
        });
      }
    });
  }
}
