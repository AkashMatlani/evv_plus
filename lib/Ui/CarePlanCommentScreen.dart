import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarePlanCommentScreen extends StatefulWidget {
  @override
  _CarePlanCommentScreenState createState() => _CarePlanCommentScreenState();
}

class _CarePlanCommentScreenState extends State<CarePlanCommentScreen> {

  var _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
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
                            hintText: LabelStr.lblSearchPatientOrPlan,
                          ),
                          keyboardType: TextInputType.text,
                        )
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: (){
                          ToastUtils.showToast(context, "Search Clicked", Colors.blueAccent);
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
              SizedBox(height: 15),
              Text(LabelStr.lblPatientOrPlan, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height:5),
              Text("Michale Johnson", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 20),
              Text(LabelStr.lblNurseName, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height:5),
              Text("Caliena Zicontrian", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
              SizedBox(height: 20),
              multilineTextFieldFor(
                "Comment here...",
                _commentController,
                140.0
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          HexColor("#1785e9"),
                          HexColor("#83cff2")
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      child: Text(LabelStr.lblSubmit,
                          style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            ToastUtils.showToast(context,
                                "Click on submit", Colors.red);
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: HexColor("#c1def8")),
                    child: FlatButton(
                      child: Text(LabelStr.lblCancel,
                          style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: HexColor("#2b91eb"))),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            ToastUtils.showToast(context,
                                "Click on cancel", Colors.red);
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
