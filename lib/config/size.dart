import 'package:flutter/material.dart';

class Size {
  static double devicewidth=0.0;
  static double deviceheight=0.0;
  static double designHeight = 1300;
  static double designWidth = 600;
  
  static init(BuildContext context) {
    devicewidth = MediaQuery.of(context).size.width;
    deviceheight = MediaQuery.of(context).size.height;
  }
  // Designer user 1300device height
  static double getProportionalHeight(height){
    return deviceheight * height / designHeight;
  }
  static double getProportionalWidth(width){
    return devicewidth * width / designWidth;
  }
}