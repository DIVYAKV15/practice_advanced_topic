import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_advanced_topic/addToCart/controller/productController.dart';
import 'package:practice_advanced_topic/addToCart/model/product.dart';
import 'package:practice_advanced_topic/addToCart/util/constant.dart';

import '../view/productDetailScreen.dart';

final Productcontroller controller = Get.put(Productcontroller());

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  Widget countButton(int index, void Function(int index) counter,
      {IconData icon = Icons.add}) {
    return RawMaterialButton(
      onPressed: () {
        counter(index);
      },
      elevation: 2.0,
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: ListView.builder(
        itemCount: controller.allProducts.length,
        itemBuilder: (context, index) {
          Product item = controller.allProducts[index];
          if (controller.isItemListScreen) {
            return listViewbody(item, index, context);
          } else if (controller.isCartScreen && item.count > 0) {
            return listViewbody(item, index, context);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget listViewbody(Product item, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ProductDetailScreen(item.itemName, item.itemImg);
            },
          ),
        );
      },
      child: Card(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: ListTile(
          leading: Image.asset(item.itemImg,
              fit: BoxFit.fill, width: 80, height: 120),
          title: Text(item.itemName, style: KItemNameStyl),
          subtitle: Text(item.Price, style: ItemPrceStyl),
          // trailing: Badge(label: Obx(() => Text()),
          //   child: ElevatedButton(onPressed: () {
          //
          //   }, child: Text("Add TO  cart"),),
          // ),
          trailing: Wrap(
            children: [
              countButton(index, controller.increase),
              Obx(() => Text(controller.allProducts[index].count.toString())),
              countButton(index, controller.decrease, icon: Icons.remove)
            ],
          ),
        ),
      ),
    );
  }
}
