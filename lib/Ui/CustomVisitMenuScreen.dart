import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Ui/CarePlanPdfScreen.dart';
import 'package:evv_plus/Ui/CommentScreen.dart';
import 'package:evv_plus/Ui/CompletedNoteScreen.dart';
import 'package:evv_plus/Ui/DailyLivingTask.dart';
import 'package:evv_plus/Ui/VisitHistoryListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../GeneralUtils/ColorExtension.dart';

class CustomVisitMenuScreen extends StatefulWidget {
  CustomVisitMenuScreen(this.scheduleDetailInfo);
  ScheduleInfoResponse scheduleDetailInfo;

  @override
  _CustomVisitMenuScreenState createState() => _CustomVisitMenuScreenState();
}

class _CustomVisitMenuScreenState extends State<CustomVisitMenuScreen> {
  List<String> menuList = [];

  @override
  void initState() {
    super.initState();
    menuList = [
      LabelStr.lblCarePlan,
      LabelStr.lblVisitDetails,
      LabelStr.lblCarePlanComments,
      LabelStr.lblDailyLivingTasks,
      LabelStr.lblComments
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Text(LabelStr.lblCustomVisit,
              style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, position) {
                return listRowItems(context, position);
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 45,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    child: Text(LabelStr.lblComplete,
                        style: AppTheme.boldSFTextStyle()
                            .copyWith(fontSize: 18, color: Colors.white)),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      checkConnection().then((isConnected) {
                        if (isConnected) {
                          Utils.navigateToScreen(context, CompletedNoteScreen());
                        } else {
                          ToastUtils.showToast(
                              context, LabelStr.connectionError, Colors.red);
                        }
                      });
                    },
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: HexColor("#c1def8"),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    child: Text(LabelStr.lblSaveExit,
                        style: AppTheme.boldSFTextStyle().copyWith(
                            fontSize: 18, color: HexColor("#2b91eb"))),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      checkConnection().then((isConnected) {
                        if (isConnected) {
                          ToastUtils.showToast(
                              context, "Click on save", Colors.blue);
                        } else {
                          ToastUtils.showToast(
                              context, LabelStr.connectionError, Colors.red);
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        if (position == 0) {
          Utils.navigateToScreen(context, CarePlanPdfScreen());
        } else if (position == 1) {
          Utils.navigateToScreen(context, VisitHistoryListScreen());
        } else if (position == 2) {
          Utils.navigateToScreen(context, CommentScreen(false, widget.scheduleDetailInfo));
        } else if (position == 3) {
          Utils.navigateToScreen(context, DailyLivingTask(widget.scheduleDetailInfo));
        } else if (position == 4) {
          Utils.navigateToScreen(context, CommentScreen(true, widget.scheduleDetailInfo));
        }
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: HexColor("#E9E9E9"),
              width: 0.5,
            )),
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero),
                  color: HexColor("#c7e4fd"),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(MyImage.ic_directory),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(menuList[position],
                      style:
                          AppTheme.mediumSFTextStyle().copyWith(fontSize: 18))),
              SizedBox(width: 10),
              Card(
                margin: EdgeInsets.only(right: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                  child: SvgPicture.asset(MyImage.ic_forword_blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
