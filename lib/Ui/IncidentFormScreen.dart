
import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CommentFilterResponse.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';


class IncidentFormScreen extends StatefulWidget {
  @override
  _IncidentFormScreenState createState() => _IncidentFormScreenState();
}

class _IncidentFormScreenState extends State<IncidentFormScreen> {

  var _searchController = TextEditingController();
  String patientName="", patientId="", filePath="", fileName="";
  int nurseId;

  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  List<CommentFilterResponse> _filterList = [];

  @override
  void initState() {
    super.initState();
    _getNurseId();
  }

  _getNurseId() async{
    nurseId = await PrefUtils.getValueFor(PrefUtils.nurseId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop('0');
      },
      child: Scaffold(
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
              Navigator.of(context).pop('0');
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
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor("#eaeff2")),
              child: Stack(
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
                                hintText: LabelStr.lblSearchPatient,
                              ),
                              keyboardType: TextInputType.text,
                              controller: _searchController,
                              onChanged: (value){
                                if(value.length == 0){
                                  setState(() {
                                    patientName = "";
                                  });
                                }
                              },
                            )),
                        Positioned(
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if(_searchController.text.trim().toString().isNotEmpty){
                                checkConnection().then((isConnected) {
                                  if(isConnected){
                                    _getFilterItemList(context, _searchController.text.toString());
                                  } else {
                                    ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
                                  }
                                });
                              }
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: _filterList.length == 0 ? Container() : _searchListView(),
                  )
                ],
              ),
            ),
            patientName.compareTo("")==0?Container():Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Text(patientName, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 25)),
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
                                uploadPDFFromStorage();
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(fileName, style: AppTheme.regularSFTextStyle()),
                          )
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
                        checkConnection().then((isConnected) {
                          if (isConnected) {
                            if(fileName.isNotEmpty){
                              uploadIncidentForm();
                            } else{
                              ToastUtils.showToast(context, LabelStr.selectFileError, Colors.red);
                            }
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
            )
          ],
        ),
      ),
    );
  }

  void _getFilterItemList(BuildContext context, String searchStr) {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.getFilterListAPICall("1", searchStr, "", (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        setState(() {
          _filterList = _nurseVisitViewModel.commentFilterList;
        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  _searchListView() {
    return Container(
      margin: EdgeInsets.only(right: 50, bottom: 5),
      color: HexColor("#eaeff2"),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _filterList.length,
        itemBuilder: (context, int index) {
          return Container(
            decoration: new BoxDecoration(
                color: HexColor("#eaeff2"),
                border: new Border(
                    bottom: new BorderSide(
                        color: Colors.grey,
                        width: 0.5
                    )
                )
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  patientName = _filterList[index].patientName;
                  patientId = _filterList[index].patientId.toString();
                  _searchController.text = patientName;
                  _filterList = [];
                });
              },
              title: Text(_filterList[index].patientName,
                  style: new TextStyle(fontSize: 18.0)),
            ),
          );
        },
      ),
    );
  }

  void uploadPDFFromStorage() async {
    var status = await Permission.storage.status;
    if(status.isGranted){
      filePath = await FlutterDocumentPicker.openDocument();
      if(filePath.contains(".pdf")){
        setState(() {
          fileName = filePath.split('/').last;
        });
      } else {
        ToastUtils.showToast(context, "Please Select only pdf file", Colors.red);
        setState(() {
          fileName = "";
        });
      }
    } else {
      Map<Permission, PermissionStatus> status = await [
        Permission.storage,
      ].request();
      print("Permission status :: $status");
    }
  }

  uploadIncidentForm(){
    Utils.showLoader(true, context);
    _nurseVisitViewModel.uploadIncidentFormApiCall(nurseId.toString(), patientId, filePath, (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        ToastUtils.showToast(context, message, Colors.green);
        Timer(Duration(seconds: 2), ()=>Utils.navigateWithClearState(context, ScheduleScreen()));
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
