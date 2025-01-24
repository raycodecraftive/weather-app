import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE }

enum APIErrorType {
  unauthorized,
  badRequest,
  notFound,
  serverError,
  noConnection,
  unknownError
}

class ApiError {
  final String? message;
  final APIErrorType errorType;

  ApiError({
    required this.message,
    this.errorType = APIErrorType.unknownError,
  });
}

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = "http://localhost:3000"});

  Future<Map<String, dynamic>> sendRequest({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse("$baseUrl/${url}");
      var request = http.Request(method.name, uri);

      print(uri);

      // set headers
      request.headers['Content-Type'] = 'application/json';

      if (body != null) {
        request.body = jsonEncode(body);
      }

      http.StreamedResponse response = await request.send();
      var rawData = await response.stream.bytesToString();
      var data = jsonDecode(rawData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is List) {
          return {"data": data};
        }
        return data;
      }
      if (response.statusCode == 401) {
        throw ApiError(
          message: "Unauthorized",
          errorType: APIErrorType.unauthorized,
        );
      }
      throw ApiError(
          message: data['message'].toString(),
          errorType: APIErrorType.unknownError);
    } on SocketException {
      throw ApiError(
        message: "No internet connection",
        errorType: APIErrorType.noConnection,
      );
    } catch (e) {
      rethrow;
    }
  }
}



// {
//     "id": 1,
//     "description": "uber charges",
//     "amount": 10.5,
//     "category": "travelling",
//     "date": "2024-12-24T15:28:01.729Z"
//   },


