import 'package:rivo_app/core/api.dart/api_variables.dart';
import 'package:rivo_app/core/api.dart/post_api.dart';
import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/features/auth/data/models/outh_response.dart';

class RemoteAuthDataSource {
  Future<AuthResponse> login(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.login(), body: body, fromJson: authResponseFromJson);
    final result = await postApi.callRequest();
    return result;
  }

  Future<AuthResponse> register(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.register(),
        body: body,
        fromJson: authResponseFromJson);
    final result = await postApi.callRequest();
    return result;
  }
}
