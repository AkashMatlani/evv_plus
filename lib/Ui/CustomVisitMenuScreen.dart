import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../GeneralUtils/ColorExtension.dart';

class CustomVisitMenuScreen extends StatefulWidget {
  @override
  _CustomVisitMenuScreenState createState() => _CustomVisitMenuScreenState();
}

class _CustomVisitMenuScreenState extends State<CustomVisitMenuScreen> {

  List<String> menuList;

  @override
  void initState() {
    super.initState();
    menuList = List<String>();
    menuList = [LabelStr.lblCarePlan, LabelStr.lblVisitDetails, LabelStr.lblCarePlanComments, LabelStr.lblDailyLivingTasks, LabelStr.lblComments];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Text(LabelStr.lblCustomVisit, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
        ),
        backgroundColor: Colors.white10,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            ToastUtils.showToast(context, "Back press", Colors.blueAccent);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, position) {
          return listRowItems(context, position);
        },
      ),
    );
  }

  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        ToastUtils.showToast(context, menuList[position], Colors.blueAccent);
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: HexColor("#E9E9E9"),
              width: 0.5,
            )
        ),
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
                      bottomRight: Radius.zero
                  ),
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
                  child: Text(menuList[position], style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 18))
              ),
              SizedBox(width: 10),
              Card(
                margin: EdgeInsets.only(right: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
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
