import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IncidentFormScreen extends StatefulWidget {
  @override
  _IncidentFormScreenState createState() => _IncidentFormScreenState();
}

class _IncidentFormScreenState extends State<IncidentFormScreen> {

  var searchController = TextEditingController();
  bool selectedPatient = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 30),
          child: Text(
            LabelStr.lblIncidentForm,
            style: AppTheme.boldSFTextStyle()
                .copyWith(fontSize: 26, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: HexColor("#efefef"),
          ),
          SizedBox(height: 5),
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10),
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
                        hintText: "Search patient name",
                      ),
                      keyboardType: TextInputType.text,
                      controller: searchController,
                    )),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      String filterKey = searchController.text.toString();
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
          SizedBox(height: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Patient name", style: AppTheme.semiBoldSFTextStyle()),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            child: Text(LabelStr.lblBrowseFile,
                                style: AppTheme.boldSFTextStyle()
                                    .copyWith(fontSize: 18, color: Colors.white)),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              ToastUtils.showToast(context, "Submit Clicked", Colors.red);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("File name")
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    child: Text(LabelStr.lblSubmit,
                        style: AppTheme.boldSFTextStyle()
                            .copyWith(fontSize: 18, color: Colors.white)),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      ToastUtils.showToast(context, "Submit Clicked", Colors.red);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
