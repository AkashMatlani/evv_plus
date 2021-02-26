import 'package:flutter/material.dart';

class SliderModel {
  final Color color;
  final String title;


  const SliderModel({
    this.title,
    this.color,
  });
}

class SliderItem{
  static List<SliderModel> loadSliderItem() {
    const fi = <SliderModel>[
      SliderModel(
        title: 'red',
        color: Colors.red
      ),
      SliderModel(
          title: 'yellow',
          color: Colors.blueAccent
      ),
      SliderModel(
          title: 'green',
          color: Colors.green
      ),
    ];

    return fi;

  }
}