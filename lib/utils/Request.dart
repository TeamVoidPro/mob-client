import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../providers/userProvider.dart';
import 'Navigation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<Response?> sendAuthPOSTRequest(String url,Object? data) async {
  String? token = Provider.of<userProvider>(Navigation.navigatorKey.currentContext!, listen: false).token;
  if(token != null) {
    String bearerToken = 'Bearer $token';

    //read BaseOptions from env
    String baseUrl = dotenv.env['API_URL'] ?? '';
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': bearerToken,
        'Content-Type': 'application/json',
      },
    );

    Dio dio = Dio(options);
    try{
      print(url);
      var res =  await dio.post(url,data:data);
      Map<String, dynamic> response = jsonDecode(res.toString());
      return res;
    }catch(e){
      if(e is DioException){
        var error = e.response;

        print(e);
        return error;
      }
      print("DioException");
      return null;
    }
  }else{
    return null;
  }

}


Future<Response?> sendAuthGETRequest(String url) async {
  String? token = Provider.of<userProvider>(Navigation.navigatorKey.currentContext!, listen: false).token;
  if(token != null) {
    String bearerToken = 'Bearer $token';

    //read BaseOptions from env
    String baseUrl = dotenv.env['API_URL'] ?? '';
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': bearerToken,
        'Content-Type': 'application/json',
      },
    );

    Dio dio = Dio(options);
    try{
      print(url);
      var res =  await dio.get(url);
      Map<String, dynamic> response = jsonDecode(res.toString());
      return res;
    }catch(e){
      if(e is DioException){
        var error = e.response;

        print(e);
        return error;
      }
      print("DioException");
      return null;
    }
  }else{
    return null;
  }

}