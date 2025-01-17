abstract class AppRoutes {
  AppRoutes._();

  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const signup = _Paths.signup;
  static const getStarted = _Paths.getStarted;
  static const quesFlow = _Paths.quesFlow;
}

abstract class _Paths {
  _Paths._();

  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const getStarted = '/getStarted';
  static const quesFlow = '/quesFlow';
}