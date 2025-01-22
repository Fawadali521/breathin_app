// // ignore_for_file: avoid_print

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:wellbands/core/responses/base_responses/request_response.dart';

// class ApiServices {
//   Future<Dio> launchDio({apiKey}) async {
//     Dio dio = Dio();
//     dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

//     dio.options.headers['content-Type'] = 'application/json';

//     dio.options.headers["Authorization"] = 'Bearer $apiKey';

//     dio.options.followRedirects = false;
//     dio.options.validateStatus = (s) {
//       if (s != null) {
//         return s < 500;
//       } else {
//         return false;
//       }
//     };
//     return dio;
//   }

//   get({required String url, params}) async {
//     Dio dio = await launchDio();
//     final response =
//         // ignore: body_might_complete_normally_catch_error
//         await dio.get(url, queryParameters: params).catchError((e) {
//       debugPrint('Unexpected Error');
//     });
//     if (response.statusCode == 200) {
//       return RequestResponse(true, error: null, data: response.data);
//     } else if (response.statusCode == 500) {
//       return RequestResponse(false, error: "Server Error", data: null);
//     } else if (response.statusCode == 401) {
//       return RequestResponse(false, error: "unauthorized Error", data: null);
//     } else {
//       return RequestResponse(false, error: "Network error", data: null);
//     }
//   }

//   post({required String url, data, params, apiKey}) async {
//     print("post api 1");
//     Dio dio = await launchDio(apiKey: apiKey);
//     print("post api 2");
//     // ignore: prefer_typing_uninitialized_variables
//     var response;
//     try {
//       response = await dio
//           .post(url, data: data, queryParameters: params)
//           // ignore: body_might_complete_normally_catch_error
//           .catchError((e) {
//         print("post api 3");
//         debugPrint('Unexpected Error $e');
//       });
//       print("post api 4");
//       if (response.statusCode == 200) {
//         print("post api 5 response => 200");
//         return RequestResponse(true, error: null, data: response.data);
//       } else if (response.statusCode == 500) {
//         print("post api 6 response => 500");
//         return RequestResponse(false, error: 'Server Error', data: null);
//       } else {
//         print("post api 7 response => Network Error");
//         return RequestResponse(false, error: 'Network Error', data: null);
//       }
//     } catch (e) {
//       print("post api 8 $e");
//       return RequestResponse(false,
//           error: "An unexpected error occured, please try agani.", data: null);
//     }
//   }

//   put({required String url, data}) async {
//     print("put 1");
//     Dio dio = await launchDio();
//     print("put 2");
//     // ignore: body_might_complete_normally_catch_error
//     final response = await dio.put(url, data: data).catchError((e) {
//       print("put 3");
//       debugPrint('Unexpected Error');
//     });
//     print("response +++> ${response.data.toString()}");
//     if (response.statusCode == 200) {
//       print("put 4");
//       return RequestResponse(true, error: null, data: response.data);
//     } else if (response.statusCode == 500) {
//       print("put 5");
//       return RequestResponse(false, error: 'Server Error');
//     } else {
//       print("put 6");
//       return RequestResponse(false, error: 'Network Error');
//     }
//   }

//   delete({required String url, params}) async {
//     print(" delete =>1");
//     Dio dio = await launchDio();
//     print(" delete =>2");
//     try {
//       final response =
//           // ignore: body_might_complete_normally_catch_error
//           await dio.delete(url, queryParameters: params).catchError((e) {
//         debugPrint('Unexpected Error');
//         print(" delete =>3");
//       });
//       print(" delete =>4");
//       if (response.statusCode == 200) {
//         return RequestResponse(true, error: null, data: response.data);
//       } else if (response.statusCode == 500) {
//         return RequestResponse(false, error: 'Server Error');
//       } else {
//         return RequestResponse(false, error: 'Network Error');
//       }
//     } catch (e) {
//       print(" delete =>5");
//       print("response delete catch");
//       return RequestResponse(false, error: 'Invalidate Token', data: null);
//     }
//   }
// }
