// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

enum RegisterStatus { initial, success, loading, failure }

class RegisterState {
  final RegisterStatus registerStatus;
  final String dateOfBrith;
  final String message;

  const RegisterState(
      {this.registerStatus = RegisterStatus.initial,
   this.dateOfBrith="يوم الميلاد",
      this.message = ""});

  RegisterState copyWith(
      {RegisterStatus? registerStatus,
      String? dateOfBrith,
      String? message}) {
    return RegisterState(
        registerStatus: registerStatus ?? this.registerStatus,
        dateOfBrith: dateOfBrith ?? this.dateOfBrith,
        message: message ?? this.message);
  }
}
