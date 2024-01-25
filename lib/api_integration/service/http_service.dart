import 'package:http/http.dart' as http;
import 'package:practice_advanced_topic/api_integration/model/productModel.dart';

class HttpService {
  static Future<List<ProductModel>> fetchProducts() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productModelFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return productModelFromJson(data);
    }
  }
}
