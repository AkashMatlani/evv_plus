import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskWithDateDetailsScreen extends StatefulWidget {
  @override
  _TaskWithDateDetailsScreenState createState() => _TaskWithDateDetailsScreenState();
}

class _TaskWithDateDetailsScreenState extends State<TaskWithDateDetailsScreen> {

  var _clientNameController = TextEditingController();
  var _clinicianNameController = TextEditingController();
  var _checkInDateController = TextEditingController();
  var _checkInTimeController = TextEditingController();
  var _checkOutDateController = TextEditingController();
  var _checkOutTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text("Task 09/12/2020", style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              ToastUtils.showToast(context, "Back press", Colors.blueAccent);
            },
          )
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              textFieldFor(LabelStr.lblClientName, _clientNameController),
              SizedBox(height: 15),
              textFieldFor(LabelStr.lblClinicianName, _clinicianNameController),
              SizedBox(height: 15),
              Text(LabelStr.lblDateNote, style: AppTheme.semiBoldSFTextStyle()),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: HexColor("#d2d2d2"), width: 1),
                  color: Colors.white
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LabelStr.lblCheckIn, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#3d3d3d"))),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.42,
                          child: textFieldFor(
                              "09/03/2020",
                              _checkInDateController,
                              suffixIcon: InkWell(
                                onTap: (){
                                  ToastUtils.showToast(context, "Date click", Colors.blue);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                  child: SvgPicture.asset(MyImage.ic_calender),
                                ),
                              )
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.02),
                        Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: textFieldFor(
                              "11:30 am",
                              _checkInTimeController,
                              suffixIcon: InkWell(
                                onTap: (){
                                  ToastUtils.showToast(context, "Time click", Colors.blue);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                  child: SvgPicture.asset(MyImage.ic_clock),
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: HexColor("#d2d2d2"), width: 1),
                    color: Colors.white
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LabelStr.lblCheckout, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#3d3d3d"))),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.42,
                          child: textFieldFor(
                              "09/03/2020",
                              _checkOutDateController,
                              suffixIcon: InkWell(
                                onTap: (){
                                  ToastUtils.showToast(context, "Date click", Colors.blue);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                  child: SvgPicture.asset(MyImage.ic_calender),
                                ),
                              )
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.02),
                        Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: textFieldFor(
                              "11:30 am",
                              _checkOutTimeController,
                              suffixIcon: InkWell(
                                onTap: (){
                                  ToastUtils.showToast(context, "Time click", Colors.blue);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                  child: SvgPicture.asset(MyImage.ic_clock)
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          HexColor("#1785e9"),
                          HexColor("#83cff2")
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      child: Text(LabelStr.lblCollectSign,
                          style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            ToastUtils.showToast(context,
                                "Client sign collection clicked", Colors.green);
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: HexColor("#c1def8")),
                    child: FlatButton(
                      child: Text(LabelStr.lblCancelVerification,
                          style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: HexColor("#2b91eb"))),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            ToastUtils.showToast(context,
                                "Client sign collection clicked", Colors.green);
                          } else {
                            ToastUtils.showToast(context,
                                LabelStr.connectionError, Colors.red);
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
