import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sharedp.dart';

class Client {
  Sharedp sharedp = Sharedp();
  Dio dio = Dio(BaseOptions());
  Client() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final toke = await sharedp.getAceestoken();
          if (toke != null) {
            options.headers["Authorization"] = "Bearer ${toke}";
            print("toke=============================");
          }
          return handler.next(options); // كمل اللب بعده
        },
        onError: (error, handler) async {
          if (error.response!.statusCode == 401) {
            if (refresh() == true) {
              final refres = await sharedp.getAceestoken();
              final requestoptions = error.requestOptions;
              requestoptions.headers["Authorization"] = "Bearer ${refres}";
              final response = await dio.fetch(requestoptions);

              /// ا  بقولي هات الرد تاني
              return handler.resolve(response);

              ///  لما الطلب بدب اقول كمل
            }
          }
          return handler.next(error);
        },
        onResponse: (response, handler) {
          final res = response.statusCode;
          if (res == 400) {}
          return handler.next(response);
        },
      ),
    );
  }

  Future<bool?> refresh() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final res = await sharedPreferences.getString("refreshToken");
    try {
      if (res == null) {
        return false;
      }
      final request = await Dio().post(
        "https://dummyjson.com/auth/refresh",
        data: {"refreshToken": res},
      );

      final newaccessTo = request.data["accessToken"];
      final newrefresh = request.data["refreshToken"];
      await sharedp.setAceestoken(newaccessTo);
      await sharedp.setRefreshtoken(newrefresh);
      return true;
    } catch (e) {
      print("Errooooooooooorrrrrrrr");
      return false;
    }
  }
}
