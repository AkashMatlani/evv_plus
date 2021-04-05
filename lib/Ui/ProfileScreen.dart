import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CityListResponse.dart';
import 'package:evv_plus/Models/StateListResponse.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GeneralUtils/ColorExtension.dart';
import '../GeneralUtils/Constant.dart';
import '../GeneralUtils/LabelStr.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _addressLineOneController = TextEditingController();
  var _addressLineTwoController = TextEditingController();
  var _zipController = TextEditingController();
  var _phoneController = TextEditingController();
  String _img64;
  final Widget svg = new SvgPicture.asset(MyImage.profileHeaderBgImage);
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;
  AuthViewModel _nurseViewModel = AuthViewModel();
  var email,
      addressLineOne,
      addressLineTwo,
      zipCode,
      phoneNumber,
      firstName,
      middleName,
      lastName,
      dateOfBirth;
  bool isLoading = true;
  String nurseId;
  List<StateData> stateList = [];
  List<CityData> cityList = [];
  String stateId;
  String cityId;
  String gender;
  String formattedStr;
  String apiDateString;
  File _image;
  String stateName="", cityName="";

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), (){
      getNurseDetails(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    if (isLoading) {
      return Container(
        color: Colors.white,
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(MyImage.profileHeaderBgImage, fit: BoxFit.fill),
                        Container(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        child: Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 20),
                                          child: Text(LabelStr.lblMyProfile,
                                              style: AppTheme.boldSFTextStyle()
                                                  .copyWith(
                                                  fontSize: 24,
                                                  color: Colors.white)),
                                        ))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: InkWell(
                                    onTap: (){
                                      _showPicker(context);
                                      },
                                    child: _image == null ? (Utils.nurseProfile.isEmpty ? defaultUserProfile() : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(Utils.nurseProfile, fit: BoxFit.cover,
                                          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
                                          },
                                        )
                                    )) : ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )),
                                  ) ,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text("${firstName + " " + lastName}",
                                      style: AppTheme.boldSFTextStyle().copyWith(
                                          fontSize: 24, color: Colors.white)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text("${stateName + ", " + cityName}",
                                      style: AppTheme.regularSFTextStyle()
                                          .copyWith(
                                          fontSize: 14,
                                          color: Colors.white))
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblSsn.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "xxx xx xxx",
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                          VerticalDivider(color: Color(0xff979797)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblDob.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                formattedStr,
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                          VerticalDivider(
                            color: Color(0xff979797),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblGender.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                gender.toUpperCase(),
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LabelStr.lblEmail.toUpperCase(),
                              style: AppTheme.semiBoldSFTextStyle()
                                  .copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              email,
                              style: AppTheme.regularSFTextStyle().copyWith(
                                  fontSize: 16, color: Color(0xff868686)),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LabelStr.lblPhone.toUpperCase(),
                              style: AppTheme.semiBoldSFTextStyle()
                                  .copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              phoneNumber,
                              style: AppTheme.regularSFTextStyle().copyWith(
                                  fontSize: 16, color: Color(0xff868686)),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Divider(color: Color(0xff979797)),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        child: textFieldFor(
                            addressLineOne, _addressLineOneController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.streetAddress)),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        child: textFieldFor(
                            addressLineTwo, _addressLineTwoController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.streetAddress)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              "State",
                              style: AppTheme.semiBoldSFTextStyle()
                                  .copyWith(fontSize: 14),
                            ),
                          )),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: HexColor("#D2D2D2"),
                                  style: BorderStyle.solid),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child:  stateList!=null && stateList.length > 0
                        ? DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            items: stateList.map((item) {
                              return  DropdownMenuItem(
                                child: Text(item.stateName),
                                value: item.stateId.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                stateId = newVal;
                                for (var i=0; i<stateList.length; i++){
                                  if(stateId.compareTo(stateList[i].stateId.toString()) == 0){
                                    stateName = stateList[i].stateName;
                                  }
                                }
                                cityList.clear();
                                cityId = "0";
                                _getCityList(stateId);
                              });
                            },
                            value: stateId,
                          ):Container(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              "City",
                              style: AppTheme.semiBoldSFTextStyle()
                                  .copyWith(fontSize: 14),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      color: HexColor("#D2D2D2"),
                                      style: BorderStyle.solid),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: 45,
                              child: cityList!=null && cityList.length>0
                                  ? DropdownButton(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: cityList.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item.cityName),
                                    value: item.cityId.toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    cityId = newVal;
                                    for (var i=0; i<cityList.length; i++){
                                      if(cityId.compareTo(cityList[i].cityId.toString()) == 0){
                                        cityName = cityList[i].cityName;
                                      }
                                    }
                                  });
                                },
                                value: cityId.compareTo("0") == 0 ? "Select City" : cityId,
                              )
                                  : Center(
                                  child: Container(
                                    child: Text("Select city"),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 2, 0),
                              height: 65,
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 0),
                              child: textFieldFor(zipCode, _zipController,
                                  autocorrect: false,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number)),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        child: textFieldFor(phoneNumber, _phoneController,
                            keyboardType: TextInputType.number, maxLength: 10)),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor("#1785e9"),
                            HexColor("#83cff2")
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextButton(
                        child: Text(LabelStr.lblUpdate,
                            style: AppTheme.mediumSFTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          checkConnection().then((isConnected) {
                            validationForCollectClientSignature();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void validationForCollectClientSignature() {
    if (_addressLineOneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineOne, Colors.red);
    } /*else if (_addressLineTwoController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineTwo, Colors.red);
    }*/ else if (stateId == null || stateList.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterState, Colors.red);
    } else if (cityId == null || cityList.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterCity, Colors.red);
    } else if (_zipController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterZip, Colors.red);
    } else if (_phoneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterPhoneNumber, Colors.red);
    }
    else {
      Utils.showLoader(true, context);
      _nurseViewModel.getUpdateProfileAPICall(
          nurseId,
          _addressLineOneController.text,
          _addressLineTwoController.text,
          _zipController.text,
          cityId,
          stateId,
          _phoneController.text,
          firstName,
          middleName,
          lastName,
          gender,
          apiDateString,
          email,
          _img64, (isSuccess, message) {
        Utils.showLoader(false, context);
        if (isSuccess) {
          ToastUtils.showToast(context, "Nurse profile updated successfully.", Colors.green);
          Timer(Duration(seconds: 2),()=> Utils.navigateWithClearState(context, ScheduleScreen()));
        } else {
          ToastUtils.showToast(context, message, Colors.red);
        }
      });
    }
  }

  void _getNurseProfileDetail(String nurseId) {
    Utils.showLoader(true, context);
    _nurseViewModel.getProfileAPICall(nurseId, (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        isLoading = false;
        getNurseDetails(false);
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  void getNurseDetails(bool isLoadingFirst) {
    imageCache.clear();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      setState(() {
        nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        email = prefs.getString(PrefUtils.email);
        addressLineOne = prefs.getString(PrefUtils.addressLineOne);
        addressLineTwo = prefs.getString(PrefUtils.addressLineTwo);
        zipCode = prefs.getString(PrefUtils.zipCode);
        phoneNumber = prefs.getString(PrefUtils.phoneNumber);
        firstName = prefs.getString(PrefUtils.firstName);
        middleName = prefs.getString(PrefUtils.MiddleName);
        lastName = prefs.getString(PrefUtils.lastName);
        gender = prefs.getString(PrefUtils.Gender);
        Utils.nurseProfile = prefs.getString(PrefUtils.NurseImage);
        dateOfBirth = prefs.getString(PrefUtils.DateOfBirth);
        formattedStr = Utils.convertDate(dateOfBirth.toString(), DateFormat("dd/MM/yyyy"));
        apiDateString = Utils.convertDate(dateOfBirth.toString(), DateFormat("yyyy-MM-dd"));
        print("formattedStr" + apiDateString);
        stateId = prefs.getInt(PrefUtils.stateId).toString();
        cityId = prefs.getInt(PrefUtils.cityId).toString();
        stateName = prefs.getString(PrefUtils.stateName);
        cityName = prefs.getString(PrefUtils.cityName);

        _addressLineOneController.text = addressLineOne;
        _addressLineTwoController.text = addressLineTwo;
        _zipController.text = zipCode;
        _phoneController.text = phoneNumber;
      });

      if(isLoadingFirst){
        checkConnection().then((isConnected) {
          if (isConnected) {
            _getNurseProfileDetail(nurseId);
            _getSateLIst();
            _getCityList(stateId);
          } else {
            ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
          }
        });
      }
    });
  }
  void _getSateLIst() {
    Utils.showLoader(true, context);
    _nurseViewModel.getStateList((isSuccess, response) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          stateList = [];
          stateList = _nurseViewModel.stateList;
          cityList = [];
        });
      } else {
        setState(() {
          stateList = [];
          cityList = [];
        });
      }
    });
  }

  void _getCityList(String stateId) {
    Utils.showLoader(true, context);
    _nurseViewModel.getCityList(stateId, (isSuccess, response) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          cityList = [];
          cityList = _nurseViewModel.cityDataList;
          cityId = cityList[0].cityId.toString();
        });
      } else {
        setState(() {
          cityList = [];
          cityId="0";
        });
      }
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      final bytes = _image.readAsBytesSync();
       _img64 = base64Encode(bytes);
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
      final bytes = _image.readAsBytesSync();
       _img64 = base64Encode(bytes);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _addressLineOneController.dispose();
    _addressLineTwoController.dispose();
    _phoneController.dispose();
    _zipController.dispose();
    super.dispose();
  }
}
