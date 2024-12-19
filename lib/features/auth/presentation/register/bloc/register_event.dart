part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

class GetRegisterEvent extends RegisterEvent {
  final RegisterParams registerParams;

  GetRegisterEvent({required this.registerParams});
}

class ChangeRegisterFailed extends RegisterEvent {
  final String? dateOfBrith;

  ChangeRegisterFailed({
    this.dateOfBrith,
  });
}
