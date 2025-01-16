import 'dart:io';

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
      // AppRoutes.authentication: (context, state, data) => routePageBuilder(child: LoginView(context,pageRouteArg: data as PageRouteArg,),path: AppRoutes.authentication,isBack: (data as PageRouteArg).isBackAction!),
      // AppRoutes.otpVerification: (context, state, data) => routePageBuilder(child: OtpValidationView(context,pageRouteArg: data as PageRouteArg,),path: AppRoutes.otpVerification,isBack: (data as PageRouteArg).isBackAction!),
      // AppRoutes.dashboard: (context, state, data) => routePageBuilder(child: DashboardPage(context,pageRouteArg: data as PageRouteArg),path: AppRoutes.dashboard,isBack: (data as PageRouteArg).isBackAction!),
      // AppRoutes.profilePage: (context, state, data) => routePageBuilder(child: ProfilePage(context,pageRouteArg: data as PageRouteArg,),path: AppRoutes.profilePage,isBack: (data as PageRouteArg).isBackAction!),

      // AppRoutes.transactionBottomNav: (context, state, data) => TransactionsView(context,pageRouteArg: data as PageRouteArg,),
      // AppRoutes.beneficiaryBottomNav: (context, state, data) => BeneficiaryManagementNavView(context),
      // AppRoutes.settingsBottomNav: (context, state, data) => SettingsPage(context),

      // '/books/:bookId': (context, state, data) {
      //   // Take the path parameter of interest from BeamState
      //   final bookId = state.pathParameters['bookId']!;
      //   // Collect arbitrary data that persists throughout navigation
      //   final info = (data as MyObject).info;
      //   // Use BeamPage to define custom behavior
      //   return BeamPage(
      //     key: ValueKey('book-$bookId'),
      //     title: 'A Book #$bookId',
      //     popToNamed: '/',
      //     type: BeamPageType.scaleTransition,
      //     child: BookDetailsScreen(bookId, info),
      //   );
      // }
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