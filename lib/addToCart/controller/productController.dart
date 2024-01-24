import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../view/cartScreen.dart';

class Productcontroller extends GetxController {
  RxList<Product> allProducts = ProductList.obs;
  bool isItemListScreen = true;
  bool isCartScreen = false;
  RxInt itemCount = 0
      .obs; //initially in cart screen the count is 0 after we add only it change
  RxDouble itemprice = 0.0
      .obs; //initially in cart screen the price is 0 after we add only it change
  Widget navigateToCartScreen(BuildContext context) {
    isCartScreen = true;
    isItemListScreen = false;
    CalculatePrice();
    return const CartScreen();
  }

  CountALlItems() {
    itemCount.value = 0;
    for (var element in allProducts) {
      itemCount.value += element.count;
    }
  }

  void CalculatePrice() {
    itemprice.value = 0.0;
    for (var element in allProducts) {
      itemprice.value =
          (double.parse(element.Price.replaceAll('\$', "").trim()) *
                  element.count) +
              itemprice.value;
    }
  }

  void increase(int index) {
    allProducts[index].count++;
    allProducts.refresh();
    CountALlItems();
    CalculatePrice();
  }

  void decrease(int index) {
    if (allProducts[index].count > 0) {
      allProducts[index].count--;
      allProducts.refresh();
      CountALlItems();
      CalculatePrice();
    }
  }

  navigateToItemListScreen() {}

  void removeItems() {
    for (var item in allProducts) {
      item.count = 0;
      allProducts.refresh();
      itemCount.value = 0;
      CalculatePrice();
    }
  }

  VoidCallback? isCheckOutButtonEnabled(){
    if(itemCount>0) return (){};
    return null;
  }
}
