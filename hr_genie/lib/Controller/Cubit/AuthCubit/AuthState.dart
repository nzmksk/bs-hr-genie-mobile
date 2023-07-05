import 'package:equatable/equatable.dart';

enum AuthStatus { notLogged, loading, loggedIn, error }

class AuthState extends Equatable {
  // final User? user;
  final bool loading;
  final bool validEmail;
  final bool isExist;
  final bool validPass;
  final String email;
  final String password;
  final AuthStatus status;

  const AuthState({
    this.validEmail = true,
    this.validPass = true,
    required this.email,
    required this.password,
    required this.status,
    this.loading = false,
    this.isExist = true,
  });
  factory AuthState.initial() {
    return const AuthState(
      email: "",
      password: "",
      status: AuthStatus.notLogged,
    );
  }
  factory AuthState.error() {
    return const AuthState(
      email: "",
      password: "",
      validPass: false,
      status: AuthStatus.error,
    );
  }
  AuthState copyWith(
      {bool? loading,
      String? email,
      String? password,
      AuthStatus? status,
      bool? isExist,
      bool? validEmail,
      bool? validPass}) {
    return AuthState(
      loading: loading ?? this.loading,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      validEmail: validEmail ?? this.validEmail,
      validPass: validPass ?? this.validPass,
      isExist: isExist ?? this.isExist,
    );
  }

  bool get isNotNull => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props =>
      [email, password, status, loading, validEmail, validPass, isNotNull];
}
