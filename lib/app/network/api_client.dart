import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../binding/central_dependecy_injection.dart';
import '../core/connection_manager/internet_cubit/internet_cubit.dart';
import '../core/utils/helper/app_helper.dart';
import '../core/utils/helper/print_log.dart';
import '../core/widgets/app_widgets.dart';
import 'api_end_points.dart';

class ApiClient {
  Dio? dio;
  late String _accessToken = ""; //todo impl

  // final String _accessToken =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI2IiwibmFtZWlkIjoiNiIsIm5hbWUiOiJ0ZXN0QGdtYWlsLmNvbSIsImp0aSI6IjYyMjQ2ZmFlLTFmMmUtNDJhNC1iMmZhLTE0MmE5YThmZGI4MCIsIm5iZiI6MTY5MjI2Nzc0NSwiZXhwIjoxNjkyMjcxMzQ1LCJpYXQiOjE2OTIyNjc3NDV9.tigC1h1e-PIAbV9sshWHUA2WfUCRo8tl7AyYFBh5pNk";

  // String token = ApiEndPoints.demoToken;

  bool _isRefreshing = false;
  final _requestsNeedRetry = <({RequestOptions options, ErrorInterceptorHandler handler})>[];


  ApiClient({customBaseUrl = ''}) {
    BaseOptions options = BaseOptions(
      baseUrl: customBaseUrl != '' ? customBaseUrl : ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      sendTimeout: const Duration(seconds: 90),
      responseType: ResponseType.plain, // To Solve Flutter FormatException: Unexpected character (at character 1)
    );

    dio = Dio(options);
  }

  Future<Response?> get(
    // BuildContext context,
    String url,
    retry, {
    Map<String, dynamic>? mQueryParameters,
    // Map<String, dynamic>? headers,
    bool isLoaderRequired = false,
    bool isHeaderRequired = false,
  }) async {

    // var internetStatusProvider = BlocProvider.of<InternetCubit>(context).state.status;

    var internetStatusProvider = getIt<InternetCubit>().state.status;

    final package = AppInfo.of(AppWidgets().globalContext).package;
    final device = AppInfo.of(AppWidgets().globalContext).platform;

    if (internetStatusProvider == InternetStatusState.connected) {

      if (kDebugMode) {
        logger.w(
            'URL:${ApiEndPoints.baseUrl}$url\nQueryParameters: $mQueryParameters');
      }

      //todo make compatible with GetX
      // AppHelper().showLoader();

      /* AppHelper().showLoader();
      AppHelper().hideKeyboard();*/

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      try {
        if (isHeaderRequired) {
          //dio?.options.headers["Authorization"] = "Bearer ${await AuthPersistenceHelper().getTokenInfo()}";
          // dio?.options.headers["Authorization"] = ApiEndPoints.demoToken;
        }

        var response = await dio?.get(url, queryParameters: mQueryParameters);
        if (kDebugMode) {
          logger.w(
              'URL:  $url\nQueryParameters: $mQueryParameters\nResponse: $response');
        }

        if (isLoaderRequired) {
          AppHelper().hideLoader();
        }
        return response;
      } on DioException catch (e) {
        handelException(e);
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          //printCatch(e, retry);
          return null;
        }
      }
    }
    else{
      AppWidgets().getSnackBar(message: "no_internet_connection_message".tr(),);
    }

    return null;
  }

  Future<Response?> post(
    // context,
    String url,
    data,
    retry, {
    Map<String, dynamic>? headers,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
    bool isFileUpload = false,
    bool isMultipart = false,
    Map<String, dynamic>? mQueryParameters,
    context,
  }) async {
    //todo make compatible with GetX

    var internetStatusProvider = getIt<InternetCubit>().state.status;

    final package = AppInfo.of(AppWidgets().globalContext).package;
    final device = AppInfo.of(AppWidgets().globalContext).platform;

    if (internetStatusProvider == InternetStatusState.connected) {

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      /* AppHelper().showLoader();
    AppHelper().hideKeyboard();*/
      // dio?.options.headers["isApp"] = true;

      try {
        if (isHeaderRequired) {
          // token = accessToken.$;
          if (isFileUpload) {
            dio?.options.baseUrl = ApiEndPoints.imageUploadUrl;
          }
          //dio?.options.headers["Authorization"] = "Bearer ${await AuthPersistenceHelper().getTokenInfo()}";
          dio?.options.headers["Content-Type"] =
              !isMultipart ? "application/json" : "multipart/form-data";
//application/json-patch+json application/json
        }
        if (kDebugMode) {
          // logger.i(
          //     'before formData URL: ${dio?.options.baseUrl}$url Data:$data token: Bearer ${await AuthPersistenceHelper().getTokenInfo()}');
        }

        FormData formData = FormData.fromMap(isFormData ? data : {});

        if (kDebugMode) {
          // logger.i(
          //     'URL:${dio?.options.baseUrl}$url Data:$data token: Bearer ${await AuthPersistenceHelper().getTokenInfo()}');
        }

        var response = await dio?.post(url,
            // data: formData,
            data: isFormData
                ? formData
                : data == null
                    ? null
                    : isJsonEncodeRequired
                        ? jsonEncode(data)
                        : data,
            queryParameters: mQueryParameters);

        if (kDebugMode) {
          logger.i('URL:  $url\nData: $data\nResponse: $response');
        }

        if(isLoaderRequired){
          AppHelper().hideLoader();
        }
        return response;
      } on DioException catch (e) {
        printLog(e.response);
        // AppWidgets().getSnackBar(
        //     title: "Info",
        //     message: "${jsonDecode(e.response.toString())["message"][0]}",
        //     backgroundColor: AppColors.primaryColor,
        //     colorText: AppColors.whitePure);
        handelException(e);
        if(isLoaderRequired){
          AppHelper().hideLoader();
        }
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else if (e.response?.statusCode == 403 ||
            e.response?.statusCode == 400) {
          return e.response;
        } else {
          //printCatch(e, retry);
          return null;
        }
      }
    }
    else {
      AppWidgets().getSnackBar(message: "no_internet_connection_message".tr(),);
    }
    return null;
  }

  Future<Object?> put(
    // BuildContext context,
    String url,
    data,
    retry, {
    Map<String, dynamic>? headers,
    bool isHeaderRequired = true,
    bool isLoaderRequired = false,
    Map<String, dynamic>? mQueryParameters,
    context,
  }) async {

    var internetStatusProvider = BlocProvider.of<InternetCubit>(context).state.status;

    final package = AppInfo.of(AppWidgets().globalContext).package;
    final device = AppInfo.of(AppWidgets().globalContext).platform;


    if (internetStatusProvider == InternetStatusState.connected) {

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      //todo make compatible with GetX
      /* AppHelper().showLoader();
    AppHelper().hideKeyboard();*/
      try {
        if (isHeaderRequired) {
          // token = accessToken.$;
          //dio?.options.headers["Authorization"] = "Bearer ${await AuthPersistenceHelper().getTokenInfo()}";
          dio?.options.headers["Content-Type"] = "application/json";
        }
        if (kDebugMode) {
          debugPrint('URL:  $data');
        }
        var response = await dio?.put(
          url,
          data: data,
          // options: Options(contentType: Headers.formUrlEncodedContentType),
          queryParameters: mQueryParameters,
        );
        if (kDebugMode) {
          logger.i('URL:  $url\nData: $data\nResponse: $response');
        }
        if(isLoaderRequired){
          AppHelper().hideLoader();
        }
        return response;
      } on DioException catch (e) {
        handelException(e);
        if(isLoaderRequired){
          AppHelper().hideLoader();
        }
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          //printCatch(e, retry);
          return null;
        }
      }
    } else {
      AppWidgets().getSnackBar(
          message: "no_internet_connection_message".tr(),);
    }
    return null;
  }

  Future<Response?> delete(
    // BuildContext context,
    String url,
    retry, {
    Map<String, dynamic>? mQueryParameters,
    Map<String, dynamic>? headers,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
  }) async {

    var internetStatusProvider = BlocProvider.of<InternetCubit>(AppWidgets().globalContext).state.status;

    final package = AppInfo.of(AppWidgets().globalContext).package;
    final device = AppInfo.of(AppWidgets().globalContext).platform;

    if (internetStatusProvider == InternetStatusState.connected) {

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }

      if (kDebugMode) {
        logger.i(
            'URL:  ${ApiEndPoints.baseUrl}$url\nQueryParameters: $mQueryParameters');
      }
      //todo make compatible with GetX
      /* AppHelper().showLoader();
    AppHelper().hideKeyboard();*/
      try {
        if (isHeaderRequired) {
          //dio?.options.headers["Authorization"] = "Bearer ${await AuthPersistenceHelper().getTokenInfo()}";
          dio?.options.headers["Content-Type"] = "application/json";
        }

        Response? response = await dio?.delete(
          url,
          queryParameters: mQueryParameters,
        );
        logger.w(
            'URL:  $url\nQueryParameters: $mQueryParameters\nResponse: $response');
        // await Future.delayed(const Duration(seconds: 3));
        if(isLoaderRequired){
          AppHelper().hideLoader();
        }
        return response;
      } on DioException catch (e) {
        handelException(e);
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          //printCatch(e, retry);
          return null;
        }
      }
    } else {
      AppWidgets().getSnackBar(
          message: "no_internet_connection_message".tr(),);
    }
  }

  Future<void> printCatch(context,DioException e, retry) async {
    if (kDebugMode) {
      logger.w('printCatch:  ${e.response?.statusCode}');
    }

    if (e.response?.statusCode == HttpStatus.internalServerError) {
      if (kDebugMode) {
        logger
            .w('printCatch: Internal Server Error: ${e.response?.statusCode} ');
      }
    }

    if (e.response?.statusCode == 400) {
    }
    else if (e.response?.statusCode == 401) {
      /*MyWidgets().showSimpleDialog(
          context, "Unauthenticated", "Please login again", retry);*/

      // if(kDebugMode){
      //   AppWidgets().getSnackBar(
      //       title: "Info",
      //       message: "Login session expired. You have to login again.");
      // }

      // await Future.delayed(const Duration(seconds: 2));
      // AppHelper().logout();

      // await AppHelper().refreshLogin();
      // await retry;
    } else if (e.response?.statusCode == 503) {
      AppWidgets().getSnackBar(
          message: "Unable Connect with server. Please try again later.");
    } else {
      //TODO clear
      /* AppWidgets().showSimpleDialog(context, "Failed",
          "Something went wrong. Please try again later.", retry);*/
      /*  message:
      "Something went wrong. Please try again later.\nStatus Code: ${e.response != null ? e.response?.statusCode : ""}",
*/
      // FlightUpdateErrorModel error =
      //     flightUpdateErrorModelFromJson(e.response?.data);

      // AppWidgets().getSnackBar(
      //     title: "Failed",
      //     // message: "Something went wrong. Please try again later.",
      //     message: e.response!.data != null ? jsonDecode(e.response!.data)["message"].toString() : "error.message",
      //     waitingTime: 5,
      //     backgroundColor: AppColors.red);
    }
    if (e.response != null) {
      if (kDebugMode) {
        logger.w('Error Response data:  ${e.response?.data}');
        logger.w('Error Response headers:  ${e.response?.headers}');
        logger.w('Error Response statusCode:  ${e.response?.statusCode}');
      }
    } else {
      if (kDebugMode) {
        logger.w('Error Response message:  ${e.message}');
      }
    }
  }

  //todo remove
  Future<dynamic> getDynamicApiData(url) async {
    var response = await Dio().get(
      "${ApiEndPoints.baseUrl}$url",
    );
    return response;
  }

  handelException(DioException e) async{
    if (e.type == DioExceptionType.connectionError && e.error is SocketException) {
      printLog('SocketException: ${e.error}');
      handelSocketException(e);
    } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout){
      printLog('Connection timeout: ${e.message}');
      handelTimeoutException(e);
    } else {
      printLog('DioException: ${e.message}');
      throw Exception(e);
    }
  }

  handelSocketException(DioException e) async{
    throw Exception(e);
  }

  handelTimeoutException(DioException e) async{
    throw Exception(e);
  }
}
