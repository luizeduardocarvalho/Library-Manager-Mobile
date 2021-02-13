import 'dart:io';

enum AuthMode {
  LOGIN,
  REGISTER
}

class AuthData {
  String name;
  String email;
  String password;
  File image;
  AuthMode _mode = AuthMode.LOGIN;

  bool get isRegister {
    return _mode == AuthMode.REGISTER;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.REGISTER : AuthMode.LOGIN;
  }
}