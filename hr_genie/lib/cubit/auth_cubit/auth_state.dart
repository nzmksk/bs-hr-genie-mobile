import 'package:equatable/equatable.dart';

enum AuthStatus { initial, filling, loading, success, error }

class AuthState extends Equatable {
  // final User? user;
  final bool loading;
  final bool validEmail;
  final bool validPass;
  final bool rememberMe;
  final String email;
  final String password;
  final AuthStatus status;

  const AuthState(
      {this.rememberMe = false,
      this.validEmail = true,
      this.validPass = true,
      required this.email,
      required this.password,
      required this.status,
      this.loading = false});
  factory AuthState.initial() {
    return const AuthState(
      email: "",
      password: "",
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith(
      {bool? loading,
      bool? rememberMe,
      String? email,
      String? password,
      AuthStatus? status,
      bool? validEmail,
      bool? validPass}) {
    return AuthState(
        loading: loading ?? this.loading,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        validEmail: validEmail ?? this.validEmail,
        validPass: validPass ?? this.validPass,
        rememberMe: rememberMe ?? this.rememberMe);
  }

  bool get isNotNull => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        loading,
        validEmail,
        validPass,
        rememberMe,
        isNotNull
      ];
}
