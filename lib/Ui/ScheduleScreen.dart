import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/Ui/ChangePwdScreen.dart';
import 'package:evv_plus/Ui/ForgotPwdScreen.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:evv_plus/Ui/PastDueScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'CompletedScheduleScreen.dart';
import 'UpcommingScheduleScreen.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int activeTabIndex = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    var tabWidth = MediaQuery.of(context).size.width / 3;
    var tabHeight = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                            hintText: "Search Here..",
                          ),
                          keyboardType: TextInputType.text,
                        )
                    ),
                    Positioned(
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: SvgPicture.asset(MyImage.ic_search),
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
                            ? _columnSelected("Past Due(20)", Colors.blue, false)
                            : _columnSelected(
                            "Past Due(20)", HexColor("#969696"), true)),
                  ),
                  Tab(
                    child: Container(
                        width: tabWidth,
                        height: tabHeight,
                        child: activeTabIndex == 1
                            ? _columnSelected("Upcomming(20)", Colors.blue, false)
                            : _columnSelected(
                            "Upcomming(20)", HexColor("#969696"), true)),
                  ),
                  Tab(
                    child: Container(
                        width: tabWidth,
                        height: tabHeight,
                        child: activeTabIndex == 2
                            ? _columnSelected("Completed(30)", Colors.blue, false)
                            : _columnSelected(
                            "Completed(30)", HexColor("#969696"), true)),
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
}
