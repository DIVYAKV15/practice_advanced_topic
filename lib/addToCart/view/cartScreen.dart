import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_advanced_topic/addToCart/controller/productController.dart';
import 'package:practice_advanced_topic/addToCart/util/constant.dart';

import '../widget_refractoring/productListView.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Productcontroller controller = Get.put(Productcontroller());
    return Scaffold(appBar: AppBar(leading: IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios),), title: const Text("Cart"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed:controller.removeItems,
            icon: const Icon(Icons.delete_forever),
          ),
        )
      ],),
      body:Column(
        children: [
          const Expanded(child: ProductListView()),
          SizedBox(
            height: 70,
            child: Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Obx(
                        () {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style:KItemNameStyl.copyWith(fontSize: 12),
                              ),
                              Text(controller.itemprice.value.toString(),
                                  style: ItemPrceStyl)
                            ],
                          ),
                          ElevatedButton(
                              onPressed: controller.isCheckOutButtonEnabled(),
                              child: const Text("Check out"))
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
