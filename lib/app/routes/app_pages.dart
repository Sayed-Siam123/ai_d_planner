import 'dart:io';

import 'package:ai_d_planner/app/modules/authentication/views/login_page.dart';
import 'package:ai_d_planner/app/modules/authentication/views/signup_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../core/utils/helper/print_log.dart';
import '../data/models/page_route_arguments.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

const transitionAnimationDuration = 200;

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.splash,
  // guards: [
  //   BeamGuard(
  //     // on which path patterns (from incoming routes) to perform the check
  //     pathPatterns: [AppRoutes.statementDetails],
  //     // return false to redirect
  //     check: (context, location) => false,
  //     // where to redirect on a false check
  //     beamToNamed: (origin, target) => AppRoutes.authentication,
  //     replaceCurrentStack: false
  //   )
  // ],
  navigatorObservers: [BeamRouterObserver()],
  locationBuilder: RoutesLocationBuilder(
    routes: {
      // Return either Widgets or BeamPages if more customization is needed
      AppRoutes.splash: (context, state, data) => routePageBuilder(child: SplashPage(),path: AppRoutes.splash,isBack: false),
      AppRoutes.login: (context, state, data) => routePageBuilder(child: LoginPage(context,pageRouteArg: data as PageRouteArg,),path: AppRoutes.login,isBack: (data as PageRouteArg).isBackAction!),
      AppRoutes.signup: (context, state, data) => routePageBuilder(child: SignupPage(context,pageRouteArg: data as PageRouteArg,),path: AppRoutes.signup,isBack: (data as PageRouteArg).isBackAction!),
    },
  ).call,
);

void toReplacementNamed(path,{PageRouteArg? args}){
  routerDelegate.beamToReplacementNamed(path,data: args);
}

void toNamed(path,{dynamic args}){
  routerDelegate.beamToNamed(path,data: args);
}

void back({PageRouteArg? pageRouteArgs}){
  routerDelegate.beamBack(
      data: pageRouteArgs
  );
}

class BeamRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    printLog('didPush: $route',level: "t");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    printLog('didPop: $route',level: "t");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    printLog('didRemove: $route',level: "t");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    printLog('didReplace: $newRoute',level: "t");
  }
}

routePageBuilder({child,path,bool isBack = false}){
  return BeamPage(
    key: ValueKey(path),
    title: path,
    name: path,
    child: child,
    routeBuilder: (context, settings, child) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = isBack ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: transitionAnimationDuration),
        reverseTransitionDuration: const Duration(milliseconds: transitionAnimationDuration),
      );
    },

    // type: !isBack ? BeamPageType.slideRightTransition : BeamPageType.slideLeftTransition,
  );
}