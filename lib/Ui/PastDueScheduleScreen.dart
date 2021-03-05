import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastDueScheduleScreen extends StatefulWidget {
  @override
  _PastDueScheduleScreenState createState() => _PastDueScheduleScreenState();
}

class _PastDueScheduleScreenState extends State<PastDueScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, position) {
          return listRowItems(context, position);
        },
      ),
    );
  }
}

listRowItems(BuildContext context, int position) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: HexColor("#969696"),
          width: 1.0,
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
                    Text("Michale Johnson", style: AppTheme.boldSFTextStyle().copyWith(fontSize: 18)),
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
            child: Text("Care plan", style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#2ab554"))),
          )
        ],
      ),
    ),
  );
}
