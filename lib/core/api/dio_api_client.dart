import 'package:dio/dio.dart';
import 'i_api_client.dart';

class DioApiClient implements IApiClient {
  factory DioApiClient() {
    _instance ??= DioApiClient._();
    return _instance!;
  }
  DioApiClient._();

  static DioApiClient? _instance;

  late final Dio _dio = Dio();

  @override
  Future<T> fetch<T>({required Uri apiUri, String? param}) async {
    final response = await _dio.getUri<T>(apiUri);
    return response.data as T;
  }
}
