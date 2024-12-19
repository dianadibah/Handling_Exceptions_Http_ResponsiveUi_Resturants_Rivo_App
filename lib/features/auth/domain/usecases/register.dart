import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/core/constant/usecases.dart';
import 'package:rivo_app/features/auth/data/models/outh_response.dart';
import 'package:rivo_app/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase extends UseCase<AuthResponse, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);
  @override
  DataResponse<AuthResponse> call(RegisterParams params) async {
    return await authRepository.register(params.getBody());
  }
}

class RegisterParams with Params {
  final String? fullname;
  final String? username;
  final String? password;
  final String? passwordConfirmation;
  final String? dateOfBirth;
  final int? gender;
  final int? cityId;
  final String? phone;
  RegisterParams(
      {this.passwordConfirmation,
      this.dateOfBirth,
      this.gender,
      this.cityId,
      this.fullname,
      this.username,
      this.password,
      this.phone
      });
  @override
  BodyMap getBody() {
    return {
      "username": username,
      "fullname": fullname,
      "date_of_birth": dateOfBirth,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "gender": gender,
      "city_id": cityId,
      "phone":phone
    };
  }
}
