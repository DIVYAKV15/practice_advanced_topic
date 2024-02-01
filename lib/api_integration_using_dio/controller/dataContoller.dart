import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/dataModel.dart';
import '../services/dioService.dart';

class DataController extends GetxController {
  // this list is observable
  RxList<DataModel> dataS = RxList(); //both are same var dataS=[].obs;
  RxBool isLoading = true.obs;
  RxBool isListDown = false
      .obs; //to show from starting when we click it will come down like in whatsapp
  RxBool isNetConnected = true.obs;
  var url = "https://jsonplaceholder.typicode.com/posts";
  var scrollController =
      ItemScrollController(); //to control position of scrollable ,it defines how much it goes down while clicking scroll button

  ///to get or fetch data from api
  fetchData() async {
    isInternetConnected();
    isLoading.value = true;
    var response = await DioService().getData(url);
    if (response.statusCode == 200) {
      response.data.forEach((data) {
        //ti iterate each data using for each here
        dataS.add(DataModel.fromJson(
            data)); //then add the each and every data in above defined empty list
      });
      isLoading.value = false;
    }
  }

  ///to check internet is connected or not
   isInternetConnected() async {
    isNetConnected.value = await InternetConnectionChecker().hasConnection;
  }

  ///scroll listView to down
  scrollToDown() {
    scrollController.scrollTo(
        index: dataS.length,
        duration: Duration(seconds: 2),
        curve: Curves.bounceIn);
    isListDown.value = true;
  }

  ///scroll listView to up when press it has to go to up
  scrollUp() {
    scrollController.scrollTo(
        index: 0, duration: Duration(seconds: 4), curve: Curves.bounceIn);
    isListDown.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    isInternetConnected();
    super.onInit();
  }
}
