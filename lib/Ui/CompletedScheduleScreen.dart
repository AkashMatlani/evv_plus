import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/CarePlanDetailsScreen.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompletedScheduleScreen extends StatefulWidget {
  @override
  _CompletedScheduleScreenState createState() => _CompletedScheduleScreenState();
}

class _CompletedScheduleScreenState extends State<CompletedScheduleScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, position) {
          return listRowItems(context, position);
        },
      ),
    );
  }
}

listRowItems(BuildContext context, int position) {
  return InkWell(
    onTap: (){
      Utils.navigateToScreen(context, CarePlanDetailsScreen());
    },
    child: Card(
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
                      Text("John Smith", style: AppTheme.boldSFTextStyle().copyWith(fontSize: 16)),
                      SizedBox(height: 3),
                      Text("10/02/2021", style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696"))),
                      SizedBox(height: 3),
                      Text("01:30 am - 02:30 pm", style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696")))
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
    ),
  );
}
