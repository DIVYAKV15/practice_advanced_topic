import 'package:get/get.dart';

//getxcontroller is hereafter monitor the changes
//make type=> observable--RxList,RxBool-->observable variable create
//=>obx observable and where the changes want so just there wrap the widget with obx
class countController extends GetxController {
  var count = 0
      .obs; //this count variable is observable so this changes will notify via getxcontroller and changes happening widget should wrap with obX
//can give similar like this too
//  RxInt _count1=0.obs;
//   RxInt _count2=RxInt(0);

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
