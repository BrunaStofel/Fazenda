import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl = 'http://localhost:8000/api';
  
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (error, handler) {
          developer.log('Dio error: ${error.message}', name: 'ApiClient');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } on DioException {
      rethrow;
    }
  }
}
