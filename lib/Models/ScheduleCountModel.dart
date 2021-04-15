import 'package:flutter/cupertino.dart';

class ScheduleCountModel with ChangeNotifier{
  String tabTitle1;
  String tabTitle2;
  String tabTitle3;

  ScheduleCountModel(this.tabTitle1, this.tabTitle2, this.tabTitle3);

  void updateCount(ScheduleCountModel model) {
    this.tabTitle1 = model.tabTitle1;
    this.tabTitle2 = model.tabTitle2;
    this.tabTitle3 = model.tabTitle3;
    notifyListeners();
  }
}