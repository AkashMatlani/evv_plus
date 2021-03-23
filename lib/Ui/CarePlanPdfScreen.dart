import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarePlanPdfScreen extends StatefulWidget {
  @override
  _CarePlanPdfScreenState createState() => _CarePlanPdfScreenState();
}

class _CarePlanPdfScreenState extends State<CarePlanPdfScreen> {

  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  String pdfUrl="";

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 100), (){
      checkConnection().then((isConnected) {
        if(isConnected){
          _getCarePlanPdfFile();
        } else {
          ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
        }
      });
    });
  }

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
              if(pdfUrl.isEmpty){
                ToastUtils.showToast(context, LabelStr.lblNoFile, Colors.blueAccent);
              } else{
                sharePdfFile();
              }
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
                      InkWell(
                        onTap: (){
                          _downloadCarePlanPdfFile("carePlanDetail.pdf");
                        },
                        child: Container(
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

  void _getCarePlanPdfFile() {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.getCarePlanPdf((isSuccess, message) {
      Utils.showLoader(false, context);
      if(isSuccess){
        ToastUtils.showToast(context, message, Colors.green);
        setState(() {
          pdfUrl = _nurseVisitViewModel.carePlanPdfPath;
          print("My Path => $pdfUrl");
        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  void sharePdfFile() async {
    var request = await HttpClient().getUrl(Uri.parse(pdfUrl));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Care plan pdf', 'careplan.pdf', bytes, '*/*');
  }

  static var httpClient = new HttpClient();
  _downloadCarePlanPdfFile(String filename) async{
    var request = await httpClient.getUrl(Uri.parse(pdfUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
   // String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$path/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url+'/'+fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      }
      else
        filePath = 'Error code: '+response.statusCode.toString();
    }
    catch(ex){
      filePath = 'Can not fetch url';
    }

    return filePath;
  }
}
