import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../binding/central_dependecy_injection.dart';
import '../../routes/app_pages.dart';
import '../../routes/app_routes.dart';
import '../connection_manager/internet_cubit/internet_cubit.dart';
import '../constants/enum_constants.dart';
import '../custom_lib/app_version_checker/flutter_app_version_checker.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/app_helper.dart';
import '../utils/helper/custom_pop_scope.dart';
import '../widgets/app_widgets.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_dialog.dart';

//ignore: must_be_immutable
abstract class BaseView extends StatefulWidget {
  BaseView({super.key});

  final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey(); // Create a key

  void initState();

  void didChangeDependencies();

  void dispose();

  void onPopBack(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  //required
  Widget body(BuildContext context);

  dynamic showBottomNav();

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> with TickerProviderStateMixin {

  final _checker = AppVersionChecker();
  //
  var internetCubit = getIt<InternetCubit>();

  @override
  initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkAppVersion();
    });

    widget.initState();
    super.initState();
  }

  @override
  didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.didChangeDependencies();
  }

  @override
  dispose() {
    // TODO: implement dispose
    super.dispose();
    // removeBackButtonIntercept();
    widget.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
        AppHelper().hideKeyboardWithSystemChannel();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomPopScope(
          onPopScope: () {
            if(AppHelper().isKeyBoardVisible(routerDelegate.navigatorKey.currentContext)){
              AppHelper().hideKeyboardWithSystemChannel();
            } else{
              widget.onPopBack(context);
            }
          },
          child: Scaffold(
            key: widget.globalScaffoldKey,
            // extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.backgroundColor,
            appBar: widget.appBar(context) ?? CustomAppBar.noAppBar(),
            drawerEnableOpenDragGesture: false,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //jailBreakOrRootCheckerWidget(context), //no need to comment out // // ios device laggy issue,need to fix first
                  internetConnectionStatusWidget(context),
                  Expanded(
                    child: widget.body(context),
                  ),
                ],
              ),
            ),
            //bottomNavigationBar: _bottomNavBarWidget(),
          ),
        ),
      ),
    );
  }

  internetConnectionStatusWidget(BuildContext context) {
    return BlocBuilder<InternetCubit,InternetState>(
      builder: (context, InternetState state) {
        Widget widget = const SizedBox();
        if (state.connectionType == ConnectionType.None) {
          widget = Container(
              width: double.infinity,
              color: AppColors.blackPure,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                "Internet Disconnected",
                style: textRegularStyle(context, isWhiteColor: true),
              ));
        }
        return widget;
      },
    );
  }

  iconsFunc(icon,{color = AppColors.liteGray}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  checkAppVersion() async {

    var checker =  await _checker.checkUpdate();

    if(routerDelegate.currentConfiguration?.uri.path == AppRoutes.login){
      if(checker.canUpdate){
        CustomDialog.customMessageDialog(mounted ? AppWidgets().globalContext : null,
          title: "Update Information",
          titleTextColor: AppColors.warningRed,
          message: "New Update Available!\n\nPlease update the app!",
          barrierDismissal: false,
          cancelButtonTitle: "Exit",
          popScope: false,
          cancelButtonTextColor: AppColors.warningRed,
          cancelButtonOnTap: () {
            // AppHelper.appExitMethod();
          },
          confirmButtonTitle: "Update Now",
          confirmButtonOnTap: () {
            // AppHelper().urlLaunch(checker.appURL,errorMessage: "Url launching error,please try again");
          },
        );
      }
    }
  }
}