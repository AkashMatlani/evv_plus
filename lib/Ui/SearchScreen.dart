import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.searchKey);
  String searchKey;

  @override
  _SearchScreenScreenState createState() => _SearchScreenScreenState();
}

class _SearchScreenScreenState extends State<SearchScreen> {

  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scheduleViewModel.getScheduleFilterAPICall((1).toString(), "test", (isSuccess, message) {
      Utils.showLoader(false, context);
      if(isSuccess){
        //_updateTabUI(searchKey, _scheduleViewModel.filterScheduleList);
        ToastUtils.showToast(context, _scheduleViewModel.filterScheduleList.length.toString(), Colors.green);
      } else {
        //_updateTabUI(searchKey, _scheduleViewModel.filterScheduleList);
        ToastUtils.showToast(context, message, Colors.red);
      }
    });

  }

  @override
  void setState(fn) {
    super.setState(fn);
    ToastUtils.showToast(context, widget.searchKey, Colors.green);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.builder(
        itemCount: _scheduleViewModel.filterScheduleList.length,
        itemBuilder: (context, position) {
          return listRowItems(context, position);
        },
      ),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      child: isLoading ? Container() : Text(LabelStr.lblNoData, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }




  listRowItems(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        // Utils.navigateToScreen(context, CarePlanDetailsScreen(_pastVisitList[position], false));
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: HexColor("#E9E9E9"),
              width: 0.5,
            )
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(MyImage.user_placeholder),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child:Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_scheduleViewModel.filterScheduleList[position].firstName, style: AppTheme.boldSFTextStyle().copyWith(fontSize: 16)),
                        SizedBox(height: 3),
                        // Text(Utils.convertDate(_pastVisitList[position].visitDate, DateFormat('dd/MM/yyyy')), style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696"))),
                        SizedBox(height: 3),
                        //Text(Utils.convertTime(_pastVisitList[position].timeFrom.substring(0, 5))+" - "+Utils.convertTime(_pastVisitList[position].timeTo.substring(0, 5)), style: AppTheme.regularSFTextStyle().copyWith(fontSize: 14, color: HexColor("#969696")))
                      ],
                    ),
                  )
              ),
              SizedBox(width: 10),
              Container(
                height: MediaQuery.of(context).size.height*0.09,
                padding: EdgeInsets.all(5),
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      margin: EdgeInsets.only(top: 3),
                      child: SvgPicture.asset(MyImage.ic_fill_circle, color: HexColor("#2ab554")),
                    ),
                    SizedBox(width: 3),
                    //Text(_pastVisitList[position].carePlanName, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#2ab554")))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
