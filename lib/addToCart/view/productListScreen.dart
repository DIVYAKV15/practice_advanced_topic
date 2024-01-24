import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_advanced_topic/addToCart/controller/productController.dart';

import '../widget_refractoring/productListView.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Productcontroller controller = Get.put(Productcontroller());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: controller.navigateToCartScreen));
        },
        child: Badge(
          label: Obx(
            () => Text(controller.itemCount.value.toString()),
          ),
          child: Icon(Icons.shopping_cart),
        ),
      ),
      body: ProductListView(),
    );
  }
}
//badge widget is used to display something about the child widget
//here we use to show the cart count abve the icon
