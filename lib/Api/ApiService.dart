import 'package:dio/dio.dart';
import 'package:flutter_application_1/Api/Dio.dart';
import 'package:flutter_application_1/Models/Edit.dart';
import 'package:flutter_application_1/Models/product.dart';
import 'package:flutter_application_1/Models/request.dart';
import 'package:flutter_application_1/Models/response.dart';
import 'package:flutter_application_1/Api/Sharedp.dart';
import 'DioSevice.dart';

class Apiservice {
  Client client = Client();
  Sharedp? sharedp;
  Future<ResponseLogin?> getData(User user) async {
    final response = await client.dio.post(
      "https://dummyjson.com/auth/login",
      data: user.toJson(),
    );
    final res = response.data;

    return ResponseLogin.fromJson(res);
  }

  Future<Product?> getProduct() async {
    final response = await client.dio.get("https://dummyjson.com/products");
    final res = response.data;
    return Product.fromJson(res);
  }

  Future<Product1?> getProduct1() async {
    final response = await client.dio.put("https://dummyjson.com/products/1");
    final res = response.data;
    return Product1.fromJson(res);
  }
}
