import 'package:evv_plus/Ui/NotificationScreen.dart';
import 'package:evv_plus/Ui/ProfileScreen.dart';
import 'package:evv_plus/Ui/UnableToSignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../GeneralUtils/ColorExtension.dart';
import '../GeneralUtils/Constant.dart';
import '../GeneralUtils/LabelStr.dart';
import '../GeneralUtils/Utils.dart';
import 'ClientPatientSignatureScreen.dart';

class NavigationDrawerScreen extends StatefulWidget {
  int _selectedIndex = 0;

  @override
  _NavigationDrawerScreenState createState() => _NavigationDrawerScreenState();
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  final List<String> _listViewData = [
    LabelStr.lblHome,
    LabelStr.lblTask,
    LabelStr.lblIcident,
    LabelStr.lblNotification,
    LabelStr.lblProfile,
    LabelStr.lblAboutUs,
  ];

  final List<String> imageData = [
    MyImage.home_icon,
    MyImage.task_icon,
    MyImage.icident_icon,
    MyImage.notification_icon,
    MyImage.profile_icon,
    MyImage.about_us_icon
  ];

  _onSelected(int index) {
    setState(() => widget._selectedIndex = index);

    if (index == 0) {
      Utils.navigateToScreen(context, ClientPatientSignatureScreen());
    }
    else if (index == 1) {
      Utils.navigateToScreen(context, UnableToSignInScreen());
    } else if (index == 3) {
      Utils.navigateToScreen(context, NotificationScreen());
    } else if (index == 4) {
      Utils.navigateToScreen(context, ProfileScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("abcd")),
      /* body: Center(child: Text('some text')),*/
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            shrinkWrap: true,
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Container(
                          padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(MyImage.user_placeholder,
                              height: 100, width: 100)),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text("Katiecomaina Willimson",
                            style: AppTheme.boldSFTextStyle()
                                .copyWith(fontSize: 22, color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text("example123@gmail.com",
                            style: AppTheme.regularSFTextStyle()
                                .copyWith(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          topLeft: Radius.zero,
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(0)),
                      gradient: LinearGradient(
                          colors: [HexColor("#1785e9"), HexColor("#83cff2")]))),
              SizedBox(
                height: 20,
              ),
              _createDrawerItem(),
              SizedBox(
                height: 30,
              ),
              _createFooterItem(
                  icon: Icons.event, text: 'Logout', onTap: () => {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _createFooterItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return Container(
      padding: EdgeInsets.all(40),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                text,
                style: AppTheme.regularSFTextStyle()
                    .copyWith(fontSize: 18, color: HexColor("#000000")),
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _createDrawerItem() {
    // return ListTile(
    //   title: Row(
    //     children: <Widget>[
    //       SvgPicture.asset(image,height: 30,width: 40,),
    //       Padding(
    //         padding: EdgeInsets.only(left: 20.0),
    //         child: Text(text,style: AppTheme.sfProLightTextStyle()),
    //       )
    //     ],
    //   ),
    //   onTap: onTap,
    // );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _listViewData.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
            // color: Colors.green,
            color:
                widget._selectedIndex != null && widget._selectedIndex == index
                    ? Color(0xff3399eb)
                    : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(35.0))),
        child: ListTile(
          minLeadingWidth: 10,
          leading:
              widget._selectedIndex != null && widget._selectedIndex == index
                  ? SvgPicture.asset(
                      imageData[index],
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    )
                  : SvgPicture.asset(imageData[index],
                      height: 20, width: 20, color: Colors.black),
          title: CustomListTile(
              _listViewData[index], widget._selectedIndex, index),
          onTap: () => _onSelected(index),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class CustomListTile extends StatelessWidget {
  var titleName;
  int selectedIndex;
  int index;

  CustomListTile(this.titleName, this.selectedIndex, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: selectedIndex == index
            ? Container(
                width: 150,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(10),
                child: Text(
                  this.titleName,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ))
            : Container(
                color: Colors.transparent,
                width: 150,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(10),
                child: Text(
                  this.titleName,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )));
  }
}
