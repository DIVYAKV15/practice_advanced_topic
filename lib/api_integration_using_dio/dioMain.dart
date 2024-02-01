import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_advanced_topic/api_integration_using_dio/view/dataHomeDio.dart';

void main() {
  runApp(DioModel());
}

class DioModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: DataHomeDio());
  }
}
//getMaterialApp is used because for navigation and all i can use get.to instead of navigation
