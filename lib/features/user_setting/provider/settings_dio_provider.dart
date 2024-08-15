import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/service_locator.dart';
import '../models/custom_api_error.dart';

typedef DioResponseData = Map<String, dynamic>;

class SettingsDioProvider {
  late final Dio _dio;

  SettingsDioProvider() {
    final box = locator<GetStorage>();
    _dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer ${box.read('accessToken')}'},
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ));
  }
  // void updateAccessToken(String token) {
  //   _accessToken = token;
  //   _dio.options.headers['Authorization'] = 'Bearer $_accessToken';
  // }

  Future<DioResponseData> get(String path,
      {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path);
      return response.data as DioResponseData;
    } on DioException catch (e) {
      final errorMessage = _checkStatus(e.response!.statusCode!)!;
      throw CustomApiError(errorMessage);
    } catch (e) {
      throw CustomApiError('An error occurred');
    }
  }

  // Future post(String path, {Map? data}) async {
  //   try {
  //     var response = await _dio.post(path, data: data);
  //     return ResponseModel.fromJson(response.data);
  //   } catch (e) {
  //     //  ErrorHandlers.allErrorHandler(e);
  //   }
  // }

  // Future putUpdate(String path, {Map? data}) async {
  //   try {
  //     var response = await _dio.put(path, data: data);
  //     return ResponseModel.fromJson(response.data);
  //   } catch (e) {
  //     ErrorHandlers.allErrorHandler(e);
  //   }
  // }

  // Future patchUpdate(String path, {Map? data}) async {
  //   try {
  //     final response = await _dio.patch(path, data: data);
  //     // return ResponseModel.fromJson(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future multipart(String path, {Map? data}) async {
  //   try {
  //     final formData = FormData.fromMap(data as Map<String, dynamic>);
  //     final response = await _dio.post(path, data: formData);
  //     return ResponseModel.fromJson(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future delete(String path, {Map? data}) async {
  //   try {
  //     var response = await _dio.delete(path, data: data);
  //     return ResponseModel.fromJson(response.data);
  //   } catch (e) {
  //     ErrorHandlers.allErrorHandler(e);
  //   }
  // }

  String? _checkStatus(int code) {
    if (code <= 400) {
      return null;
    }
    if (code == 401) {
      return 'Unauthorized request. Please login.';
    }
    if (code == 404) {
      return 'Could\'nt find the resource';
    }
    return 'An error occurred';
  }
}

final settingsDioProvider = Provider<SettingsDioProvider>((ref) {
  return SettingsDioProvider();
});
