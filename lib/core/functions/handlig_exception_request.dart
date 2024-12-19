import 'dart:convert';

import '../errors/exceptions.dart';
import 'package:http/http.dart';

mixin HandlingExceptionRequest {
  Exception getException({required Response response}) {
    final String message = json.decode(response.body)['message'];
    if (response.statusCode == 401) {
      return UnauthenticatedExeption();
    }
    return ServerException(message);
  }
}
