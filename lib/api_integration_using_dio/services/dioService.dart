import 'package:dio/dio.dart';

class DioService {
  // var url = "https://jsonplaceholder.typicode.com/posts"; can add here too
  Future<dynamic> getData(String url) async {
    Dio dio = Dio();
    return await dio
        .get(url,
            options: Options(method: 'GET', responseType: ResponseType.json))
        .then((response) => response); //return the response
  }
}
