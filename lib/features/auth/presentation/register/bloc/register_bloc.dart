import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rivo_app/core/constant/global_functions.dart';
import 'package:rivo_app/features/auth/data/repository/repo_imp.dart';
import 'package:rivo_app/features/auth/domain/usecases/register.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final registerUseCase = RegisterUseCase(AuthRepositoryImp());
  RegisterBloc() : super(const RegisterState()) {
    on<GetRegisterEvent>(_mapRegisterState);
    on<ChangeRegisterFailed>(_mapChangeState);
  }
  FutureOr<void> _mapRegisterState(
      GetRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    final resulte = await registerUseCase(event.registerParams);
    resulte.fold(
        (failure) => emit(state.copyWith(
            registerStatus: RegisterStatus.failure,
            message: failure.message)), (response) {
      emit(state.copyWith(
        registerStatus: RegisterStatus.success,
      ));
      GlobalFunctions.setToken(response.data!.user!.accessToken!);
      log("token is:${response.data!.user!.accessToken!.toString()}");
      GlobalFunctions.setUserId(response.data!.user!.id!);
    });
  }

  FutureOr<void> _mapChangeState(
      ChangeRegisterFailed event, Emitter<RegisterState> emit) {
    emit(state.copyWith(dateOfBrith: event.dateOfBrith));
  }
}
