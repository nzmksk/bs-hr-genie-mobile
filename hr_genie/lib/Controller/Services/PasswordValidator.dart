class PasswordValidatorService {
  static final RegExp _upperCaseRegExp = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegExp = RegExp(r'[a-z]');
  static final RegExp _digitRegExp = RegExp(r'\d');
  static final RegExp _specialCharRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static bool isStrongPassword(String password) {
    if (password == "" || password.isEmpty) {
      return false;
    }
    if (password.length < 8) {
      print("Please password length should be more than 8 Characters");
      return false;
    }

    if (!_upperCaseRegExp.hasMatch(password)) {
      print("ATTENTION:Please include Uppercase");
      return false;
    }

    if (!_lowerCaseRegExp.hasMatch(password)) {
      print("ATTENTION:Please include Lowercase");
      return false;
    }

    if (!_digitRegExp.hasMatch(password)) {
      print("ATTENTION:Please include Number");
      return false;
    }

    if (!_specialCharRegExp.hasMatch(password)) {
      print("ATTENTION:Please include Special Characters");
      return false;
    }
    print("ATTENTION: Now it's fine");

    return true;
  }

  String errorTypeMsg() {
    return "Error";
  }
}
