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
        return null;
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
        return "";
      case MSG.loginPassword:
        return "Your password is invalid!";
      case MSG.newPassword:
        return "Your new password invalid";
      case MSG.repeatPassword:
        return "";
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
