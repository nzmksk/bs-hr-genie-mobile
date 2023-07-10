import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';

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
  final String accessToken;
  final String refreshToken;
  final String? errorMessage;
  final Employee? userData;

  const AuthState({
    this.validEmail = true,
    this.validPass = true,
    required this.email,
    required this.password,
    required this.status,
    this.userData,
    this.loading = false,
    this.isExist = true,
    this.accessToken = "",
    this.refreshToken = "",
    this.errorMessage,
  });
  factory AuthState.initial() {
    return const AuthState(
      email: "",
      password: "",
      status: AuthStatus.notLogged,
      accessToken: "",
      refreshToken: "",
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
  AuthState copyWith({
    bool? loading,
    String? email,
    String? password,
    AuthStatus? status,
    bool? isExist,
    bool? validEmail,
    bool? validPass,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
    Employee? userData,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      validEmail: validEmail ?? this.validEmail,
      validPass: validPass ?? this.validPass,
      isExist: isExist ?? this.isExist,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
    );
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
        isNotNull,
        accessToken,
        refreshToken,
        errorMessage,
        userData,
      ];
}
