import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarePlanDetailsScreen extends StatefulWidget {
  @override
  _CarePlanDetailsScreenState createState() => _CarePlanDetailsScreenState();
}

class _CarePlanDetailsScreenState extends State<CarePlanDetailsScreen> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.012429, 72.510775),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    var boxWidth = MediaQuery.of(context).size.width*0.6/2;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.zero,
                            topLeft: Radius.zero,
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(100)
                        ),
                        gradient: LinearGradient(
                            colors: [
                              HexColor("#1785e9"),
                              HexColor("#83cff2")
                            ]
                        )
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){ Navigator.of(context).pop();},
                              child: Container(
                                child: Icon(Icons.arrow_back, color: Colors.white),
                                margin: EdgeInsets.only(left: 10),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(LabelStr.lblCarePlan, style: AppTheme.mediumSFTextStyle().copyWith(fontSize:22, color: Colors.white)),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text("12th March 2021", style: AppTheme.boldSFTextStyle().copyWith(fontSize: 30, color: Colors.white)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.5, color: Colors.white)
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                width: boxWidth - 2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LabelStr.lblCheckIn, style: AppTheme.regularSFTextStyle().copyWith(fontSize:14, color: Colors.white)),
                                    SizedBox(height: 3),
                                    Text("00:00 am", style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                width: 1,
                                color: Colors.white,
                              ),
                              Container(
                                width: boxWidth - 2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LabelStr.lblCheckout, style: AppTheme.regularSFTextStyle().copyWith(fontSize:14, color: Colors.white)),
                                    SizedBox(height: 3),
                                    Text("00:00 am", style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.62,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 25, top: 60, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Michale Johnson", style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 34)),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LabelStr.lblAge, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                                SizedBox(height: 5),
                                Text("38 years", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LabelStr.lbNurse, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                                SizedBox(height: 5),
                                Text("Selena Gomz", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(LabelStr.lbPatientAddress, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                        SizedBox(height: 5),
                        Text("3921, Kenwood place, orlando florida, 32801USA",
                            style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.black12)
                          ),
                          height: 180,
                          alignment: Alignment.center,
                          child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              }
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                HexColor("#1785e9"),
                                HexColor("#83cff2")
                              ]),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            child: Text(LabelStr.lbStartVisit,
                                style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              checkConnection().then((isConnected) {
                                if (isConnected) {
                                  _showDialog(context);
                                } else {
                                  ToastUtils.showToast(context,
                                      LabelStr.connectionError, Colors.red);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.3,
              left: 25,
              right: -50,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(MyImage.user_placeholder, height: 120, width: 120),
                    InkWell(
                      onTap:() {},
                      child: Expanded(
                        child: SvgPicture.asset(MyImage.ic_call_icons, height: 130, width: 130)
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
                height: MediaQuery.of(context).size.height*0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(LabelStr.lbStartVisit, style: AppTheme.headerTextStyle().copyWith(fontSize: 20)),
                    ),
                    Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
                          child: Text(
                            LabelStr.lblAskStartVisit,
                            style: AppTheme.mediumSFTextStyle().copyWith(color: HexColor("#3d3d3d")),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor("#f5f5f5"),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 51,
                      child: Row(
                        children: [
                          Container(
                            height: 51,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.4,
                            child: TextButton(
                                child: Text(LabelStr.lblNo, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          SizedBox(width: 1),
                          Container(
                            width: 1,
                            height: 51,
                            color: HexColor("#f5f5f5"),
                          ),
                          Container(
                            height: 51,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.4,
                            child: TextButton(
                                child: Text(LabelStr.lblYes, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20, color: HexColor("#1a87e9"))),
                                onPressed: () {
                                  Timer(
                                    Duration(milliseconds: 200),
                                        () => Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => CustomVisitMenuScreen())),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }
}
