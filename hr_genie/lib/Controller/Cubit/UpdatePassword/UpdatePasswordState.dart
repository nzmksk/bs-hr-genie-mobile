import 'package:equatable/equatable.dart';

enum UpdatePasswordStatus { initial, loading, success, error }

class UpdatePasswordState extends Equatable {
  final String newPassword;
  final String repeatPassword;
  final bool isMatched;
  final bool newPassValid;
  final bool repeatPassEmpty;
  final UpdatePasswordStatus status;

  const UpdatePasswordState({
    required this.status,
    required this.newPassword,
    required this.repeatPassword,
    this.isMatched = false,
    this.newPassValid = true,
    this.repeatPassEmpty = true,
  });

  factory UpdatePasswordState.initial() {
    return const UpdatePasswordState(
      newPassword: "",
      repeatPassword: "",
      status: UpdatePasswordStatus.initial,
    );
  }

  UpdatePasswordState copyWith({
    String? newPassword,
    String? repeatPassword,
    bool? isMatched,
    bool? newPassValid,
    bool? repeatPassEmpty,
    UpdatePasswordStatus? status,
  }) {
    return UpdatePasswordState(
        newPassword: newPassword ?? this.newPassword,
        repeatPassword: repeatPassword ?? this.repeatPassword,
        isMatched: isMatched ?? this.isMatched,
        newPassValid: newPassValid ?? this.newPassValid,
        repeatPassEmpty: repeatPassEmpty ?? this.newPassValid,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [newPassword, repeatPassword, isMatched, newPassValid, repeatPassEmpty];
}
