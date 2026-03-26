import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/product.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoad extends ProductState {}

final class ProductSucess extends ProductState {
  Product pro;
  ProductSucess({required this.pro});
}

final class ProductFail extends ProductState {
  String fail;
  ProductFail(this.fail);
}
