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
  print(token);
  if(token != null) {
    String bearerToken = 'Bearer $token';

    //read BaseOptions from env
    String baseUrl = dotenv.env['API_URL'] ?? '';
    print(baseUrl);

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': bearerToken,
        'Content-Type': 'application/json',
      },
    );
    Dio dio = Dio(options);
    try{
      return await dio.post(url, data: data);
    }catch(e){
      if(e is DioException){
        var error = e.response;
        return error;
      }
      return null;
    }
  }else{
    return null;
  }

}