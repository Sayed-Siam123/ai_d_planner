abstract class AppRoutes {
  AppRoutes._();

  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const signup = _Paths.signup;
}

abstract class _Paths {
  _Paths._();

  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
}