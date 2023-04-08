import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();
  String jwtToken;

  API(this.jwtToken) {
    _dio.options.baseUrl = 'http://205.134.254.135/~mobile/MtProject/public/api';
    _dio.options.headers = {'token': jwtToken};
    // _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
