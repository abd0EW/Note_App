import 'package:dio/dio.dart';
import 'package:flutter_application_1/Api/Sharedp.dart';

class Diosevice {
  Diosevice() {
    Dio dio = Dio();
    Sharedp? sharedp;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? resultToken = await sharedp!.getAceestoken();
          dio.options.headers["Authorization"] = "Bearer ${resultToken}";
          return handler.next(options);
        },
        onError: (error, handler) {},
        onResponse: (response, handler) {},
      ),
    );
  }
}
