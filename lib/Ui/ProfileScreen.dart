import 'dart:async';
import 'dart:io';

import 'package:evv_plus/GeneralUtils/AddressSearch.dart';
import 'package:evv_plus/GeneralUtils/GooglePlaceService.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../GeneralUtils/ColorExtension.dart';
import '../GeneralUtils/Constant.dart';
import '../GeneralUtils/LabelStr.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var _searchAddressController = TextEditingController();
  var _addressLineOneController = TextEditingController();
  var _addressLineTwoController = TextEditingController();
  var _stateController = TextEditingController();
  var _cityController = TextEditingController();
  var _zipController = TextEditingController();
  var _phoneController = TextEditingController();
  final Widget svg = new SvgPicture.asset(MyImage.profileHeaderBgImage);
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;
  AuthViewModel _nurseViewModel = AuthViewModel();

  final int maxLength = 5;
  bool isLoading = true;
  String nurseId, email, firstName, middleName, lastName, phoneNumber, gender;
  String addressLineOne, addressLineTwo, zipCode, displayAddress;
  String stateName = "", cityName = "";
  String formattedStr, apiDateString;
  File _image;


  @override
  void initState() {
    super.initState();
    _getNurseId();
  }

  _getNurseId() async {
    int id = await PrefUtils.getValueFor(PrefUtils.nurseId);
    nurseId = id.toString();
    checkConnection().then((isConnected) {
      if (isConnected) {
        _getNurseProfileDetail();
      } else {
        ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
      }
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
      return WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop('0');
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(MyImage.profileHeaderBgImage,
                          fit: BoxFit.fill),
                      Container(
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop('0');
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
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: _image == null
                                      ? (Utils.nurseProfile.isEmpty
                                      ? defaultUserProfile()
                                      : ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: Image.network(
                                        Utils.nurseProfile,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent
                                            loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(
                                                      Colors.white)));
                                        },
                                      )))
                                      : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )),
                                ),
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
                                          color: Colors.white))),
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
                              "xxx-xx-xxxx".toUpperCase(),
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
                            phoneNumber.toString().contains("-")?phoneNumber:formatNumbersAsCode(phoneNumber),
                            style: AppTheme.regularSFTextStyle().copyWith(
                                fontSize: 16, color: Color(0xff868686)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(color: Color(0xff979797)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(LabelStr.lblSearchAddress, style: AppTheme.mediumSFTextStyle()),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          displayAddress, _searchAddressController,
                          autocorrect: false,
                          readOnly: true,
                          onTap: () async{
                            final sessionToken = Uuid().v4();
                            final Suggestion result = await showSearch(
                              context: context,
                              delegate: AddressSearch(sessionToken),
                            );
                            // This will change the text displayed in the TextField
                            if (result != null) {
                              setState(() {
                                displayAddress = result.description;
                                _searchAddressController.text = result.description;
                                addressLineOne = result.description.split(",")[0];
                                _addressLineOneController.text = result.description.split(",")[0];
                              });

                              var apiClient = PlaceApiProvider(sessionToken);
                              Utils.showLoader(true, context);
                              apiClient.getPlaceDetailFromId(result.placeId).then((place) async {
                                final coordinates = Coordinates(place.latitude, place.longitude);
                                var mLocation = await Geocoder.local.findAddressesFromCoordinates(coordinates);

                                setState(() {
                                  cityName = mLocation.first.locality;
                                  stateName = mLocation.first.adminArea;
                                  zipCode = mLocation.first.postalCode;

                                  _cityController.text = cityName;
                                  _stateController.text = stateName;
                                  _zipController.text = zipCode;
                                });
                                Utils.showLoader(false, context);
                              });
                            }
                          },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(LabelStr.lblApartment, style: AppTheme.mediumSFTextStyle()),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          addressLineTwo, _addressLineTwoController,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(LabelStr.lblAddress, style: AppTheme.mediumSFTextStyle()),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          addressLineOne, _addressLineOneController,
                          autocorrect: false,
                          readOnly: true,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(LabelStr.lblState, style: AppTheme.mediumSFTextStyle()),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          stateName, _stateController,
                          autocorrect: false,
                          readOnly: true,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(LabelStr.lblCity, style: AppTheme.mediumSFTextStyle()),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 65,
                                padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                child: textFieldFor(
                                    cityName,
                                    _cityController,
                                    keyboardType: TextInputType.text,
                                    readOnly: true
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(LabelStr.lblZipcode, style: AppTheme.mediumSFTextStyle()),
                            ),
                            Container(
                                height: 65,
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                child: textFieldFor(
                                    zipCode,
                                    _zipController,
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(maxLength)
                                    ],
                                    keyboardType: TextInputType.number,
                                    maxLength: 5,
                                    readOnly: true
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(LabelStr.lblContactNo, style: AppTheme.mediumSFTextStyle()),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          "123-456-7890", _phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          inputFormatter: [
                            MaskTextInputFormatter(
                                mask: '###-###-####',
                                filter: {"#": RegExp(r'[0-9]')})
                          ])),
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
          ),
        ),
      );
    }
  }

  formatNumbersAsCode(String number) {
    int groupDigits = 0;
    String tmp = "";
    for (int i = 0; i < number.length; ++i) {
      tmp += number[i];
      ++groupDigits;
      if (groupDigits == 3) {
        if (tmp.length > 8) {
          tmp += "";
        } else {
          tmp += "-";
        }
        groupDigits = 0;
      }
    }
    return tmp;
  }

  void validationForCollectClientSignature() {
    if (_addressLineOneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineOne, Colors.red);
    }
    else if (_zipController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterZip, Colors.red);
    } else if (_zipController.text.isNotEmpty && _zipController.text.length != 5) {
      ToastUtils.showToast(context, LabelStr.enterValidZip, Colors.red);
    } else if (_phoneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterPhoneNumber, Colors.red);
    } else if (_phoneController.text.length !=12) {
      ToastUtils.showToast(context, LabelStr.enterValidPhoneNumber, Colors.red);
    } else {
      Utils.showLoader(true, context);
      _nurseViewModel.getUpdateProfileAPICall(
          nurseId,
          _addressLineOneController.text,
          _addressLineTwoController.text,
          _zipController.text,
          _phoneController.text,
          cityName,
          stateName,
          firstName,
          middleName,
          lastName,
          gender,
          apiDateString,
          email,
          displayAddress,
          _image != null ? _image.path : null, (isSuccess, message) {
        Utils.showLoader(false, context);
        if (isSuccess) {
          ToastUtils.showToast(context, "Nurse profile updated successfully.", Colors.green);
          Timer(Duration(seconds: 2), () {
            imageCache.clear();
            Utils.navigateWithClearState(context, ScheduleScreen());
          });
        } else {
          ToastUtils.showToast(context, message, Colors.red);
        }
      });
    }
  }

  void _getNurseProfileDetail() {
    Utils.showLoader(true, context);
    _nurseViewModel.getProfileAPICall(nurseId, (isSuccess, message) {
      if (isSuccess) {
        getNurseDetails();
      } else {
        Utils.showLoader(false, context);
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }

  void getNurseDetails() {
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
        String dateOfBirth = prefs.getString(PrefUtils.DateOfBirth);
        formattedStr = Utils.convertDate(dateOfBirth, DateFormat("MM/dd/yy"));
        apiDateString = Utils.convertDate(dateOfBirth, DateFormat("yyyy-MM-dd"));
        stateName = prefs.getString(PrefUtils.stateName);
        cityName = prefs.getString(PrefUtils.cityName);
        displayAddress = prefs.getString(PrefUtils.displayAddress);

        _searchAddressController.text = displayAddress;
        _addressLineOneController.text = addressLineOne;
        _addressLineTwoController.text = addressLineTwo;
        _cityController.text = cityName;
        _stateController.text = stateName;
        _zipController.text = zipCode;
        if (phoneNumber.toString().contains("-")) {
          _phoneController.text = phoneNumber;
        } else {
          _phoneController.text = formatNumbersAsCode(phoneNumber);
        }
      });
      isLoading = false;
      Utils.showLoader(false, context);
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
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