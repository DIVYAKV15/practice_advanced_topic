import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:practice_advanced_topic/api_integration/screen/widget/productTile.dart';

import '../controller/productController.dart';

void main() {
  runApp(GetMaterialApp(
    home: HomeProduct(),
  ));
}

class HomeProduct extends StatelessWidget {
  const HomeProduct({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController productcontroller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SizedBox(
        child: Obx(() {
          // Obx is to make the widget observable
          if (productcontroller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
                itemCount: productcontroller.productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 5 / 9, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return ProductTile(productcontroller.productList[index]);
                });
          }
        }),
      ),
    );
  }
}
