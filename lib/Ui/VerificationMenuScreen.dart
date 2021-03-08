import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../GeneralUtils/ColorExtension.dart';

class VerificationMenuScreen extends StatefulWidget {
  @override
  _VerificationMenuScreenState createState() => _VerificationMenuScreenState();
}

class _VerificationMenuScreenState extends State<VerificationMenuScreen> {

  List<String> menuNameList;
  List<String> menuIconList;

  @override
  void initState() {
    super.initState();
    menuNameList = List<String>();
    menuNameList = [LabelStr.lblPatientSign, LabelStr.lblPatientVoice, LabelStr.lblSignReason];

    menuIconList = List<String>();
    menuIconList = [MyImage.ic_medical, MyImage.ic_voice_chat, MyImage.ic_document];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Text(LabelStr.lblVisitVerification, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
        itemCount: menuNameList.length,
        itemBuilder: (context, position) {
          return listRowItems(context, position);
        },
      ),
    );
  }

  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        ToastUtils.showToast(context, menuNameList[position], Colors.blueAccent);
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
                  child: SvgPicture.asset(menuIconList[position]),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(menuNameList[position], style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 18))
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
