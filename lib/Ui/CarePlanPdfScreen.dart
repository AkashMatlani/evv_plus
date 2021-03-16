import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarePlanPdfScreen extends StatefulWidget {
  @override
  _CarePlanPdfScreenState createState() => _CarePlanPdfScreenState();
}

class _CarePlanPdfScreenState extends State<CarePlanPdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          alignment: Alignment.center,
          child: Text(LabelStr.lblCarePlan,
              style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
        ),
        backgroundColor: Colors.white10,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: SvgPicture.asset(MyImage.ic_share),
            onPressed: () {
              ToastUtils.showToast(context, "Share clicked", Colors.blueAccent);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: HexColor("#efefef"),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                color: Colors.white,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor("#e9e9e9"),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(MyImage.ic_pdf_thumb),
                      ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        child: Text(LabelStr.lblPlaneForm,
                            style: AppTheme.boldSFTextStyle()
                                .copyWith(fontSize: 16)),
                      ),
                      SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              HexColor("#1785e9"),
                              HexColor("#83cff2")
                            ]),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(MyImage.ic_download),
                            SizedBox(width: 10),
                            Text(LabelStr.lblDownloadPdf,
                                style: AppTheme.mediumSFTextStyle()
                                    .copyWith(color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
