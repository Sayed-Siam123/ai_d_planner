import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../routes/app_routes.dart';

class SettingsPage extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  SettingsPage(this.context,{super.key,this.pageRouteArg});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(context,
      "Settings",
      backgroundColor: AppColors.backgroundColor,
      elevation: 0.0,
      navBarColor: AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
      onBackTap: () {
        _onPopBackMethod();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {
              toNamed(
                  AppRoutes.changePassword,
                args: PageRouteArg(
                  to: AppRoutes.changePassword,
                  from: AppRoutes.settings,
                  pageRouteType: PageRouteType.goNamed,
                ),
              );
            },
            title: Text("Change Password",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 18),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {
              toNamed(
                AppRoutes.changeUserName,
                args: PageRouteArg(
                  to: AppRoutes.changeUserName,
                  from: AppRoutes.settings,
                  pageRouteType: PageRouteType.goNamed,
                ),
              );
            },
            title: Text("Change Name",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 18),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  void onPopBack(BuildContext context) {
    _onPopBackMethod();
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  void _onPopBackMethod() {
    toReplacementNamed(
      AppRoutes.dashboard,
      args: PageRouteArg(
        from: AppRoutes.settings,
        isBackAction: true,
        pageRouteType: PageRouteType.pushReplacement,
        to: AppRoutes.dashboard,
      ),
    );
  }
}
