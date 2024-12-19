import '../constant/tybe_def.dart';

class ApiVariables {
  static const String _scheme = "https";
  static const String _host = "api-cashlock.lve-co.com";

  static Uri _mainUri({required String path, QueryParams? queryParam}) {
    Uri uri = Uri(
        scheme: _scheme,
        host: _host,
        path: "api/$path",
        queryParameters: queryParam);
    return uri;
  }

  static Uri _userUri({required String path, QueryParams? queryParam}) {
    return _mainUri(path: "user/$path");
  }

  static Uri _auth({required String path, QueryParams? queryParam}) {
    return _mainUri(path: "user/auth/$path", queryParam: queryParam);
  }

  static Uri login() => _auth(path: "login");
  static Uri register() => _auth(path: "register");
  static Uri logout() => _auth(path: "logout");
  static Uri indexResturant({ QueryParams? queryParam}) {
    return _userUri(path:"indexResturant",queryParam: queryParam);
  }
  static Uri indexSubscribedResturants({ QueryParams? queryParam}) {
    return _userUri(path: "indexSubscribedResturants",queryParam: queryParam);
  }
}
