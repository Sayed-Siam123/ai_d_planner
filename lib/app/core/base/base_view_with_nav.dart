import 'dart:io';

import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/widgets/custom_dialog.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/chatbot/chat_bot_page.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/views/explore_page.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/views/profile_page.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/views/question_page.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/views/response_generation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../../binding/central_dependecy_injection.dart';
import '../../data/models/page_route_arguments.dart';
import '../../modules/dashboard/tabs/home/home_page.dart';
import '../../modules/dashboard/tabs/questions/bloc/question_page_bloc.dart';
import '../../routes/app_pages.dart';
import '../../services/bottom_nav_state/bloc/bottom_nav_cubit.dart';
import '../../services/bottom_nav_state/bloc/bottom_nav_state.dart';
import '../connection_manager/internet_cubit/internet_cubit.dart';
import '../constants/enum_constants.dart';
import '../constants/size_constants.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/app_helper.dart';
import '../utils/helper/custom_pop_scope.dart';
import '../utils/helper/print_log.dart';
import '../widgets/app_widgets.dart';
import '../widgets/custom_app_bar.dart';

//ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  DashboardPage(this.context, {super.key,this.pageRouteArg});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  PageController? pageController;

  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey();

  final _homePageKey = GlobalKey();
  final GlobalKey<ScaffoldState> _explorePageKey = GlobalKey();
  final GlobalKey<ScaffoldState> _chatPageKey = GlobalKey();
  final GlobalKey<ScaffoldState> _profilePageKey = GlobalKey();
  final _quesAnsPageKey = GlobalKey();

  final _responseGenPageKey = GlobalKey();

  var internetProvider = getIt<InternetCubit>();
  var exploreBloc = getIt<ExploreBloc>();


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    pageControllerInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavStateCubit, BottomNavStateState>(
      builder: (context, state) => GestureDetector(
        onTap: () {
          // FocusScope.of(context).unfocus();
          AppHelper().hideKeyboardWithSystemChannel();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomPopScope(
            onPopScope: () {
              if (state.currentIndex! == 0) {
                // CustomBottomSheet().appExit(
                //   context,
                //   message: "logout_app_bottom_message",
                //   okButtonTitle: "logout".tr(),
                //   onOkButtonPressed: () async {
                //     Navigator.of(globalScaffoldKey.currentContext!).pop();
                //     await logoutFunc();
                //   },
                // );
              } else if (state.currentIndex! == 1) {
                animateToPage(context, index: 0);
              } else if (state.currentIndex! == 2) {
                animateToPage(context, index: 0);
              } else if (state.currentIndex! == 3) {
                animateToPage(context, index: 0);
              } else if(AppHelper().isKeyBoardVisible(routerDelegate.navigatorKey.currentContext)){
                AppHelper().hideKeyboardWithSystemChannel();
              }
              // else {
              //   back();
              // }
            },
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                key: globalScaffoldKey,
                backgroundColor: AppColors.backgroundColor,
                appBar: showAppBar(context, pageController),
                drawerEnableOpenDragGesture: false,
                extendBodyBehindAppBar: true,
                body: Column(
                  children: [
                    // jailBreakOrRootCheckerWidget(context),
                    internetConnectionStatusWidget(context),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        onPageChanged: (index) {
                          //pageChanged(index);
                          _currentIndex = index;
                        },
                        children: <Widget>[
                          HomePage(key: _homePageKey,pageController: pageController,), //0
                          ExplorePage(key: _explorePageKey,pageController: pageController,), //1
                          //ChatBotPage(key: _chatPageKey,pageController: pageController,),
                          ProfilePage(key: _profilePageKey,), //2
                          QuestionPage(key: _quesAnsPageKey,pageController: pageController), //3
                          ResponseGenerationPage(key: _responseGenPageKey,pageController: pageController,) //4
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBarWidget(
                  currentIndex: _currentIndex,
                  pageController: pageController,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  internetConnectionStatusWidget(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<InternetCubit>(),
      builder: (context, InternetState state) {
        Widget widget = const SizedBox();
        if (state.connectionType == ConnectionType.None) {
          widget = Container(
              width: double.infinity,
              color: AppColors.blackPure,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                "No Internet Connection",
                style: textRegularStyle(context, isWhiteColor: true),
              ));
        }
        return widget;
      },
    );
  }

  showAppBar(context, PageController? pageController) {
    var internetCubit = getIt<InternetCubit>();
    var currentIndex = BlocProvider.of<BottomNavStateCubit>(context).state.currentIndex!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        SystemChrome.setSystemUIOverlayStyle(AppHelper().systemOverlayStyle(
          color: AppColors.transparentPure,
          navBarColor: AppColors.transparentPure,
          isDarkBrightness: currentIndex != 0
              ? (Platform.isIOS ? false : true)  // Reverse for non-zero index
              : (Platform.isIOS ? true : false),
        )); //forcefully change status bar color and nav bar color change
      });
    });

    PreferredSizeWidget appBar = CustomAppBar.noAppBar(
      statusBarColor: AppColors.transparentPure,
      isDarkBrightness: true,
      navBarColor: AppColors.transparentPure,
    );

    if (currentIndex == 0) {
      appBar = CustomAppBar.noAppBar2(
        statusBarColor: AppColors.transparentPure,
        isDarkBrightness: true,
        navBarColor: AppColors.transparentPure,
      );
    } else if (currentIndex == 1) {
      appBar = CustomAppBar.customAppBar(
        context,
        StringConstants.appBarTitleLovePlanAI,
        isCenterTitle: true,
        statusBarColor: AppColors.backgroundColor,
        navBarColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        isDarkBrightness: true,
        elevation: 0.0,
        actionWidget: [
          /*
          * exploreBloc.add(SortPlansByDateEvent(ascending: ascending));
          * */

          Material(
            color: AppColors.transparentPure,
            borderRadius: BorderRadius.circular(roundRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(roundRadius),
              onTap: () {
                exploreBloc.add(SortPlansByDateEvent(ascending: exploreBloc.ascending));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.filter_list_outlined,size: 24,),
              ),
            ),
          ),

          AppWidgets().gapW16(),
          Material(
            color: AppColors.transparentPure,
            borderRadius: BorderRadius.circular(roundRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(roundRadius),
              onTap: () {

                CustomDialog.customLocationDateTimeDialog(
                  context,
                  confirmButtonTitle: "Submit",
                  cancelButtonTitle: "Close",
                  onConfirm: (location, dateTime) {
                    // printLog("Location: $location");
                    // printLog("DateTime: $dateTime");

                    // exploreBloc.add(FetchAllPlans());

                    exploreBloc.add(FilterPlansEvent(
                      // startDate: dateTime,
                      location: location
                    ));

                  },
                  onCancel: () {
                    printLog("Dialog Cancelled");
                  },
                  onReset: () {
                    exploreBloc.add(FetchAllPlans());
                  },
                );
                // exploreBloc.add(FilterPlansEvent(
                //     // startDate: DateTime(2025, 02, 27),
                //   location: "New"
                // ));
                // exploreBloc.add(FetchAllPlans());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(AntDesign.filter,size: 24),
              ),
            ),
          ),
          AppWidgets().gapW16(),
        ]
        // onBackTap: () {
        //   animateToPage(context, index: 0);
        //   //AppHelper().bottomTabChangeFunc(context, 0);
        // },
      );
    } else if (currentIndex == 2) {
      appBar = CustomAppBar.customAppBar(
        context,
        StringConstants.appBarTitleLovePlanAI,
        isCenterTitle: true,
        statusBarColor: AppColors.backgroundColor,
        navBarColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        isDarkBrightness: true,
        elevation: 0.0,
        // onBackTap: () {
        //   animateToPage(context, index: 0);
        // },
      );
    } else if (currentIndex == 3) {
      appBar = CustomAppBar.customAppBar(
        context,
        StringConstants.appBarTitleLovePlanAI,
        isCenterTitle: true,
        statusBarColor: AppColors.backgroundColor,
        navBarColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        isDarkBrightness: false,
        elevation: 0.0,
        // onBackTap: () {
        //   animateToPage(context, index: 0);
        // },
      );
    }
    return appBar;
  }

  animateToPage(context, {index}) {
    if(internetProvider.state.status == InternetStatusState.connected){
      pageController?.jumpToPage(
        index,
        // duration: const Duration(milliseconds: transitionAnimationDuration), curve: Curves.ease
      );

      // pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 200), curve: Curves.linear
      // );
      var bottomNavStateCubit = BlocProvider.of<BottomNavStateCubit>(context);
      bottomNavStateCubit.onChangeBottomNav(index);
    } else{
      AppWidgets().getSnackBar(
          status: SnackBarStatus.warning,
          message: "No internet connection. Please connect to internet first"
      );
    }
  }

  logoutFunc() async {
    //logout network call will be set here
    //then-->
    // toReplacementNamed(AppRoutes.authentication);
    // await clearAll();

    // await AppHelper().logout();
  }

  clearAll() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    // getIt<HomeBloc>().add(ResetHome());
    // getIt<TransactionBloc>().add(ResetTransactions());
  }

  pageControllerInitialization() async{

    var bottomNavStateCubit = getIt<BottomNavStateCubit>();
    pageController = PageController(initialPage: 0);
    bottomNavStateCubit.onChangeBottomNav(0);

    // if(widget.pageRouteArg?.from == AppRoutes.beneficiaryManagementList){
    //   //if it is coming from beneficiaryManagementCreate then the page will initialize pageController to index == 2
    //   pageController = PageController(initialPage: 2);
    //   bottomNavStateCubit.onChangeBottomNav(2);
    // } else if(widget.pageRouteArg?.from == AppRoutes.balanceTransferOwn){
    //   //if it is coming from balanceTransferOwn then the page will initialize pageController to index == 2
    //   pageController = PageController(initialPage: 2);
    //   bottomNavStateCubit.onChangeBottomNav(2);
    // } else if(widget.pageRouteArg?.from == AppRoutes.balanceTransferCompletePage){
    //   //if it is coming from balanceTransferCompletePage then the page will initialize pageController to index == 0
    //   var homeBloc = getIt<HomeBloc>();
    //   homeBloc.add(FetchHomeData());
    //
    //   pageController = PageController(initialPage: 0);
    //   bottomNavStateCubit.onChangeBottomNav(0);
    // }
    // else{
    //   //other wise the page will initialize pageController to index == 0
    //   //then I will only use else if for new page, otherwise else for all
    //   pageController = PageController(initialPage: 0);
    //   bottomNavStateCubit.onChangeBottomNav(0);
    // }
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  final int? currentIndex;

  final PageController? pageController;

  BottomNavigationBarWidget({super.key, this.currentIndex = 0, this.pageController});

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var internetCubit = getIt<InternetCubit>();

    return BlocBuilder<BottomNavStateCubit, BottomNavStateState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
          ),
          child: SizedBox(
            child: BottomNavigationBar(
              currentIndex: state.currentIndex!,
              selectedLabelStyle: textRegularStyle(context, color: AppColors.primaryColor, fontSize: 12,fontWeight: FontWeight.w500),
              unselectedLabelStyle: textRegularStyle(context, color: AppColors.liteGray, fontSize: 12,fontWeight: FontWeight.w400),
              enableFeedback: false,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              backgroundColor: AppColors.whitePure,
              //landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
              items: [
                BottomNavigationBarItem(
                  icon: iconsFunc(
                    homeNavInActive,
                  ),
                  label: 'Home',
                  activeIcon: iconsFunc(
                    homeNavActive,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: iconsFunc(
                    exploreNavInActive
                  ),
                  label: 'Explore',
                  activeIcon: iconsFunc(
                    exploreNavActive,
                  ),
                ),
                // BottomNavigationBarItem(
                //   icon: iconsFunc(
                //     chatBotNavInActive
                //   ),
                //   label: "Chatbot",
                //   activeIcon: iconsFunc(
                //     chatBotNavActive
                //   ),
                // ),
                BottomNavigationBarItem(
                  icon: iconsFunc(
                    profileNavInActive
                  ),
                  label: "Profile",
                  activeIcon: iconsFunc(
                    profileNavActive
                  ),
                ),
              ],
              // onTap: (index) => _beamerDelegate.beamToNamed(
              //   index == 0 ? AppRoutes.homeBottomNav
              //       : index == 1 ? AppRoutes.transactionBottomNav
              //       : index == 2 ? AppRoutes.beneficiaryBottomNav
              //       : AppRoutes.settingsBottomNav,
              // ),
              onTap: (value) {

                printLog(value);

                /*if(value == 2 || value == 1){
                  AppWidgets().getSnackBar(status: SnackBarStatus.info,message: "upcoming_feature".tr());
                } else{
                  widget.pageController?.jumpToPage(
                    value,
                    // duration: Duration(milliseconds: 200), curve: Curves.ease
                  );

                  var bottomNavStateCubit = BlocProvider.of<BottomNavStateCubit>(context);
                  bottomNavStateCubit.onChangeBottomNav(value);
                }*/



                if(internetCubit.state.status == InternetStatusState.connected){
                  widget.pageController?.jumpToPage(
                    value,
                    // duration: const Duration(milliseconds: transitionAnimationDuration), curve: Curves.ease
                  );

                  var bottomNavStateCubit = getIt<BottomNavStateCubit>();
                  bottomNavStateCubit.onChangeBottomNav(value);
                } else{
                  AppWidgets().getSnackBar(
                      status: SnackBarStatus.warning,
                      message: "No internet connection. Please connect to internet first"
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  iconsFunc(icon, {color = AppColors.liteGray,int? size = 25}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      // child: Icon(
      //   icon,
      //   color: color,
      // ),
      child: Image.asset(icon,height: double.parse(size.toString()),width: double.parse(size.toString()),color: AppColors.primaryColor,),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}