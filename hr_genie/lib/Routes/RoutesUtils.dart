enum PAGES {
  login,
  forgotPassword,
  home,
  leave,
  leaveApp,
  leaveDetails,
  account,
  error,
}

extension AppRouteExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.home:
        return "/";
      case PAGES.login:
        return "/login";
      case PAGES.forgotPassword:
        return "forgotPassword";
      case PAGES.leave:
        return "/leave";
      case PAGES.leaveApp:
        return "application";
      case PAGES.leaveDetails:
        return "details";
      case PAGES.account:
        return "/account";
      case PAGES.error:
        return "/error";
      default:
        return "/";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.home:
        return "HOME";
      case PAGES.login:
        return "LOGIN";
      case PAGES.forgotPassword:
        return "FORGOT PASSWORD";
      case PAGES.leave:
        return "LEAVE";
      case PAGES.leaveApp:
        return "LEAVE FORM";
      case PAGES.leaveDetails:
        return "LEAVE DETAILS";
      case PAGES.account:
        return "ACCOUNT";
      case PAGES.error:
        return "ERROR";
      default:
        return "HOME";
    }
  }

  String get screenTitle {
    switch (this) {
      case PAGES.home:
        return "Home";
      case PAGES.login:
        return "Login";
      case PAGES.forgotPassword:
        return "Forgot Password";
      case PAGES.leave:
        return "Leave";
      case PAGES.leaveApp:
        return "Leave Application";
      case PAGES.leaveDetails:
        return "Leave Details";
      case PAGES.account:
        return "Account";
      case PAGES.error:
        return "Error";
      default:
        return "Home";
    }
  }
}
