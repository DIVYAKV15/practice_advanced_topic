import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:practice_advanced_topic/api_integration_using_dio/controller/dataContoller.dart';
import 'package:practice_advanced_topic/api_integration_using_dio/utils/colors.dart';
import 'package:practice_advanced_topic/api_integration_using_dio/utils/constSnackBar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class DataHomeDio extends StatelessWidget {
//   DataHomeDio({super.key});
//
//   DataController dataController = Get.put(DataController());
//
//   ///initialize the controller
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.bgColor,
//       appBar: AppBar(
//           title: const Text(
//             "Dio Example",
//           ),
//           backgroundColor: MyColors.secColor),
//       floatingActionButton: Obx(() =>
//           dataController.isNetConnected.value ? _buildFab() : Container()),
//       body: Obx(() => SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           //if internet is connected then data loading meantime it will show circular to load from api
//           child: dataController.isNetConnected.value
//               ? (dataController.isLoading.value
//                   ? const Center(child: CircularProgressIndicator())
//                   : getData())
//               : noInternet(context)
//           // : const Text("no iternet",
//           //     style: TextStyle(
//           //         fontSize: 25,
//           //         fontWeight: FontWeight
//           //             .bold)), //if no net instead of text we can add animation here
//           )),
//     );
//   }
//
// //to return floatingaction button
//   FloatingActionButton _buildFab() {
//     return FloatingActionButton(
//       onPressed: () {
//         dataController.isListDown
//                 .value //if the list down is true and when press it goes up or it goes down
//             ? dataController.scrollUp()
//             : dataController.scrollToDown();
//       },
//       backgroundColor: MyColors.prColor,
//       child: FaIcon(dataController.isListDown
//               .value //if the list is down then show arrow up or show arrow down
//           ? FontAwesomeIcons.arrowUp
//           : FontAwesomeIcons.arrowDown),
//     );
//   }
//
//   RefreshIndicator getData() {
//     return RefreshIndicator(
//         child: ScrollablePositionedList.builder(
//             itemScrollController: dataController.scrollController, //to control
//             itemCount: dataController.dataS.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 // onTap: Get.to(page),
//                 child: Card(
//                   child: ListTile(
//                     leading: CircleAvatar(
//                         backgroundColor: MyColors.secColor,
//                         child: Text(dataController.dataS[index].id.toString())),
//                     //as the id is number so converting as tostring or interpolation
//                     title: Text(
//                         "${dataController.dataS[index].title}"), //it string only but some case we have to give interpolation
//                   ),
//                 ),
//               );
//             }),
//         onRefresh: () {
//           return dataController.fetchData();
//         });
//   }
//
//   Center noInternet(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("no iternet",
//               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//           MaterialButton(
//             color: MyColors.prColor,
//             child: const Text("try Again"),
//             onPressed: ()async{
//              if( await InternetConnectionChecker().hasConnection)
//                {
//                dataController.fetchData();
//                }
//     else {
//                 showCustomSnackBar(context);
//               }
//             },
//             //can use both ways
//             // onPressed: () {
//             //   if (dataController.isNetConnected.value) {
//             //     dataController.fetchData();
//             //   }
//             //   else {
//             //     showCustomSnackBar(context);
//             //   }
//             // },
//           ),
//         ],
//       ),
//     );
//   }
// }
class DataHomeDio extends StatelessWidget {
  DataController controller = Get.put(DataController());

  /// initialize the controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Dio"),
        backgroundColor: MyColors.secColor,
      ),
      backgroundColor: MyColors.prColor,
      floatingActionButton: Obx(
              () => controller.isNetConnected.value ? _buildFAB() : Container()),
      body: Obx(() => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: controller.isNetConnected.value
              ? (controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : getData())
              : noInternet(context)
      )),
    );
  }

  RefreshIndicator getData() {
    return RefreshIndicator(onRefresh: (){
      return controller.fetchData();
    },
      child: ScrollablePositionedList.builder(
          itemScrollController:controller.scrollController  ,
          itemCount: controller.dataS.length,
          itemBuilder: (context,index){
            return InkWell(
              // onTap: ()=>Get.to(),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: MyColors.secColor,
                    child: Text(controller.dataS[index].id.toString()),
                  ),
                  title: Text("${controller.dataS[index].title}"),
                  subtitle: Text("${controller.dataS[index].body}"),
                ),
              ),
            );
          }),);
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        controller.isListDown.value
            ? controller.scrollUp()
            : controller.scrollToDown();
      },
      backgroundColor: MyColors.prColor,
      child: FaIcon(controller.isListDown.value
          ? FontAwesomeIcons.arrowUp19
          : FontAwesomeIcons.arrowDown19),
    );
  }

  Center noInternet(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No Internet"),
          MaterialButton(
              color: MyColors.prColor,
              child: const Text("Try Again"),
              onPressed: ()async{
                if(await InternetConnectionChecker().hasConnection){
                  controller.fetchData();
                }else{
                  showCustomSnackBar(context);
                }
              })
        ],
      ),
    );
  }

}