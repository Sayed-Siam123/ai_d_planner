import 'dart:async';
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'app/binding/central_dependecy_injection.dart';
import 'app/core/style/app_colors.dart';
import 'app/core/utils/helper/multi_bloc_providers_list.dart';
import 'app/core/utils/helper/print_log.dart';
import 'app/core/widgets/app_widgets.dart';
import 'app/modules/home_screen.dart';
import 'app/routes/app_pages.dart';

void main() async{
  printLog("appStart");

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // await routeSetup();
    // await firebaseConfig();

    await dependencySetup();

    // var path = await getTemporaryDirectory();
    //
    // Hive.init(path.path);

    // await Hive.initFlutter();

    // HydratedBloc.storage = await HydratedStorage.build(
    //     storageDirectory: kIsWeb
    //         ? HydratedStorage.webStorageDirectory
    //         : await getTemporaryDirectory(),
    // );

    // Bloc.observer = AppBlocObserver();

    Bloc.observer = TalkerBlocObserver(
      settings: const TalkerBlocLoggerSettings(
        enabled: true,
        printEventFullData: true,
        printStateFullData: true,
        printChanges: true,
        printClosings: true,
        printCreations: true,
        printEvents: true,
        printTransitions: true,
        // // If you want log only AuthBloc transitions
        // transitionFilter: (bloc, transition) =>
        // bloc.runtimeType.toString() == 'AuthBloc',
        // // If you want log only AuthBloc events
        // eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'AuthBloc',
      ),
    );

    await ScreenUtil.ensureScreenSize();

    runApp(AppInfo(
      data: await AppInfoData.get(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
              overlays: [SystemUiOverlay.bottom]);
          // dark status bar text color
          // SystemChrome.setSystemUIOverlayStyle(
          //   SystemUiOverlayStyle(
          //     statusBarColor: AppColors.primaryColor,
          //     statusBarIconBrightness: Brightness.light,
          //     statusBarBrightness: Brightness.dark,
          //   ),
          // );
          // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.9, 1.1);

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
            child: MyApp(
              connectivity: Connectivity(),
            ),
          );
        },
      ),
    ));
  }, (exception, stackTrace) async {
    log(exception.toString(), stackTrace: stackTrace);
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
  });
}

class MyApp extends StatefulWidget {

  final Connectivity? connectivity;

  const MyApp({super.key,this.connectivity});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProvidersList,
      child: MaterialApp.router(
        title: 'Marooned VPN',
        builder: EasyLoading.init(),
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        scaffoldMessengerKey: AppWidgets.snackBarKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dialogTheme: DialogTheme(
              elevation: 0,
              backgroundColor: AppColors.whitePure,
              actionsPadding: const EdgeInsets.all(8),
              surfaceTintColor: AppColors.transparentPure,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              )),
          colorScheme:
          ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        // home: HomeScreen(),
      ),
    );
  }
}
