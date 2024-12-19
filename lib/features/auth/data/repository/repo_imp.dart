import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/core/functions/handling_exception_manager.dart';
import 'package:rivo_app/features/auth/data/data_source/remote_auth_data_source.dart';
import 'package:rivo_app/features/auth/data/models/outh_response.dart';
import 'package:rivo_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp
    with HandlingExceptionManager
    implements AuthRepository {
  final authDataSource = RemoteAuthDataSource();
  @override
  DataResponse<AuthResponse> login(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      final result = await authDataSource.login(body);
      return result;
    });
  }

  @override
  DataResponse<AuthResponse> register(BodyMap body) {
    return wrapHandling(tryCall: () async {
      final result = await authDataSource.register(body);
      return result;
    });
  }
}
