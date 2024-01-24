class Product {
  String itemName;
  String Price;
  String color;
  int count;
  String itemImg;

  Product(this.itemName, this.Price, this.count, this.color, this.itemImg);
}

List<Product> ProductList = [
  Product("item1", "100\$", 0, "red", "assets/images/beans.jpg"),
  Product('item2', "200\$", 0, 'blue', 'assets/images/bitter.jpg'),
  Product('item3', "300\$", 0, 'green', 'assets/images/capsicum.jpg'),
  Product('item4', "400\$", 0, 'yellow', 'assets/images/carot.jpg'),
  Product('item5', "500\$", 0, 'purple', 'assets/images/lfingers.jpg'),
  Product('item6', "600\$", 0, 'black', 'assets/images/raddish.jpg'),
  Product('item7', "700\$", 0, 'brown', 'assets/images/tomato.jpg'),
  Product('item8', "800\$", 0, 'pink', 'assets/images/turnip.jpg'),
  Product('item9', "900\$", 0, "black", 'assets/images/cauliflower.jpg')
];
