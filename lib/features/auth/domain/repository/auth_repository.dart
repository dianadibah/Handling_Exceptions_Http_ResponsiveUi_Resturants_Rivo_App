import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/features/auth/data/models/outh_response.dart';

abstract class AuthRepository {
  DataResponse<AuthResponse> login(BodyMap body);
  DataResponse<AuthResponse> register(BodyMap body);
}
