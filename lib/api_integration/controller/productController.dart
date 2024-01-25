import 'package:get/get.dart';
import 'package:practice_advanced_topic/api_integration/service/http_service.dart';

class ProductController extends GetxController
{
  var isLoading=true.obs;
  var productList=[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getProducts();
    super.onInit();
  }
  void  getProducts()
  async{
    try{
      isLoading(true);
      var products = await HttpService.fetchProducts();
      if(products != null){
        productList.value = products;
      }
    }catch(e){
      print(e);
    }finally{
      isLoading(false);
    }
  }}