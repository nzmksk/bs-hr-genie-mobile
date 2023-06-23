enum MSG {
  loginEmail,
  loginPassword,
  newPassword,
  repeatPassword,
}

extension StatusMessage on MSG {
  String? get initialMsg {
    switch (this) {
      case MSG.loginEmail:
        return "";
      case MSG.loginPassword:
        return "";
      case MSG.newPassword:
        return "";
      case MSG.repeatPassword:
        return "";
      default:
        return "";
    }
  }

  String get errorMsg {
    switch (this) {
      case MSG.loginEmail:
        return "Your Email is Invalid";
      case MSG.loginPassword:
        return "Your password is invalid!";
      case MSG.newPassword:
        return "Password should be between 8 - 14 Characters.\n(Including numbers, Special Characters, Uppercase \n& Lowercase letters)";
      case MSG.repeatPassword:
        return "Password does not matched";
      default:
        return "";
    }
  }

  String get successMsg {
    switch (this) {
      case MSG.loginEmail:
        return "";
      case MSG.loginPassword:
        return "";
      case MSG.newPassword:
        return "";
      case MSG.repeatPassword:
        return "";
      default:
        return "";
    }
  }
}
