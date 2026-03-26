import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/Api/ApiService.dart';
import 'package:flutter_application_1/cubit/cubit/cubit/cubit/product_state.dart';
import 'package:meta/meta.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  Apiservice api = Apiservice();
  Future<void> getProduct() async {
    emit(ProductLoad());
    try {
      final res = await api.getProduct();
      emit(ProductSucess(pro: res!));
    } catch (e) {
      print("error");
      emit(ProductFail(e.toString()));
    }
  }
}
