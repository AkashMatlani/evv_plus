import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VisitHistoryListScreen extends StatefulWidget {
  @override
  _VisitHistoryListScreenState createState() => _VisitHistoryListScreenState();
}

class _VisitHistoryListScreenState extends State<VisitHistoryListScreen> {
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
            ToastUtils.showToast(context, "Back press", Colors.blueAccent);
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
              itemCount: 3,
              itemBuilder: (context, position) {
                return listRowItems(context, position);
              },
            ),
          )
        ],
      ),
    );
  }
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
              child: Image.asset(MyImage.noImagePlaceholder),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child:Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Michale Johnson", style: AppTheme.boldSFTextStyle().copyWith(fontSize: 16)),
                    SizedBox(height: 3),
                    Text("09/02/2021", style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696"))),
                    SizedBox(height: 3),
                    Text("11:30 am - 12:30 pm", style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696")))
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
                Text("Care plan", style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#2ab554")))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
