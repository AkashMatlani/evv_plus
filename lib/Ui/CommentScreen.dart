import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/Ui/CarePlanCommentScreen.dart';
import 'package:evv_plus/Ui/PatientCommentScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
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
    var tabHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 30),
          child: Text(LabelStr.lblCarePlan, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: HexColor("#efefef"),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                width: 220,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: Container(
                          height: tabHeight,
                          child: activeTabIndex == 0
                              ? _columnSelected(LabelStr.lblPatient, Colors.blue, false)
                              : _columnSelected(
                              LabelStr.lblPatient, HexColor("#969696"), true)),
                    ),
                    Tab(
                      child: Container(
                          height: tabHeight,
                          child: activeTabIndex == 1
                              ? _columnSelected(LabelStr.lblCarePlan, Colors.blue, false)
                              : _columnSelected(
                              LabelStr.lblCarePlan, HexColor("#969696"), true)),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      PatientCommentScreen(),
                      CarePlanCommentScreen()
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
