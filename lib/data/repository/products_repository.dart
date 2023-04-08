import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manektech_demo/data/modal/product_modal.dart';
import 'package:manektech_demo/data/repository/api/api.dart';

class ProductsRepository {
  API api = API('eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz');

  Future<List<ProductModal>> fetchProducts(int page) async {
    try {
      Response response = await api.sendRequest.post('/product_list.php', data: {'page': page, 'perPage': 5});
      Map<String, dynamic> responseMap = json.decode(response.data);
      List<dynamic> productListMap = responseMap['data'];
      // log(productListMap.toString());
      return productListMap.map((e) => ProductModal.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
