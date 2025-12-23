import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api/', // IP pour l'émulateur Android
    headers: {'Accept': 'application/json'},
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final box = GetStorage();
        String? token = box.read('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));
  }
}
