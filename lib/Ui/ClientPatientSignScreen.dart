import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import 'VerificationMenuScreen.dart';


enum visitVerification { patient, voice }
class ClientPatientSignScreen extends StatefulWidget {
  CompletedNoteResponse completedNoteResponse;
  var finalValue;
  bool clientPatient;
  ClientPatientSignScreen(this.completedNoteResponse,[this.clientPatient,this.finalValue]);

  @override
  _ClientPatientSignatureScreenState createState() =>
      _ClientPatientSignatureScreenState();
}

class _ClientPatientSignatureScreenState
    extends State<ClientPatientSignScreen> {
  var pngBytes;
  var image;
  File signfile;
  String signSSPath;
  String signSSName;
  String fullSignPath;
  File newImage;
  String base64Image;
  String path = '/storage/emulated/0/Evv';

  AuthViewModel _nurseViewModel = AuthViewModel();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Container(
              child: Text(
                LabelStr.lblclientSignature,
                style: AppTheme.boldSFTextStyle().copyWith(fontSize: 24),
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () async {
                  if (_controller.isNotEmpty) {
                    var data = await _controller.toPngBytes();
                    if (await Permission.storage.request().isGranted) {
                      await _createFile(data);
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.only(right: 10),
                  child: Center(
                    child: Text(LabelStr.lblDone,
                        style: AppTheme.boldSFTextStyle().copyWith(
                          fontSize: 20,
                          color: HexColor("#1a87e9"),
                        )),
                  ),
                ),
              )
            ],
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                  ),
                  child: IntrinsicHeight(
                      child: Column(children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: HexColor("#efefef"),
                    ),
                    /* Container(
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
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60),
                            Expanded(
                              child: Container(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Shani Bhavsar',
                                        style: AppTheme.boldSFTextStyle()
                                            .copyWith(
                                                fontSize: 30,
                                                color: HexColor("#000000")))),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    LabelStr.lblSignHere,
                                    style: AppTheme.regularSFTextStyle()
                                        .copyWith(
                                            fontSize: 18,
                                            color: HexColor("#000000")),
                                  )),
                            )),
                          ],
                        ),
                      ),
                    ),*/
                    Center(
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 400,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              color: Colors.white,
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor("#e9e9e9"),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Signature(
                                    width: 380,
                                    controller: _controller,
                                    height: 250,
                                    backgroundColor: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: _controller.clear,
                        child: Text('Clear',
                            style: AppTheme.boldSFTextStyle().copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor("#1785e9"),
                                  HexColor("#83cff2")
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextButton(
                              child: Text(LabelStr.lblSubmit,
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 18, color: Colors.white)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkConnection().then((isConnected) async {
                                  if (_controller.isNotEmpty) {
                                    var data = await _controller.toPngBytes();
                                    if (await Permission.storage
                                        .request()
                                        .isGranted) {
                                      await _createFile(data);
                                    }
                                  }
                                });
                              },
                            ),
                          )),
                    ),
                  ]))));
        }));
  }

  Future<String> _createFile(var data) async {
    Uint8List bytes = data;
    final result = await ImageGallerySaver.saveImage(bytes);
    print(result);
    String _img64 = base64Encode(bytes);
    print("base64Camera-->>" + _img64);
    validationForCollectClientSignature(_img64);
  }

  void validationForCollectClientSignature(String img64) {
    Utils.showLoader(true, context);
    _nurseViewModel.getPatientSignature(
        "1",
        img64,
        null,
        widget.completedNoteResponse.nurseId.toString(),
        widget.completedNoteResponse.patientId.toString(),
        widget.completedNoteResponse.id.toString(), (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          widget.finalValue=visitVerification.patient;

          Utils.isPatientSignCompleted=true;
          Utils.navigateToScreen(
              context, VerificationMenuScreen(widget.completedNoteResponse));
        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }

    });
  }
}
