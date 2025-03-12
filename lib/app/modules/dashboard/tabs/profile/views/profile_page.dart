import 'dart:io';

import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_state.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:ai_d_planner/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/helper/app_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var authBloc = getIt<AuthenticationBloc>();
  var profileBloc = getIt<ProfileBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            AppWidgets().gapH(40),
            // Image.asset(profilePicDummy,height: 80,),
            Icon(Icons.account_circle,size: 110,color: AppColors.primaryColor,),
            AppWidgets().gapH(16),
            BlocBuilder<ProfileBloc,ProfileState>(
              builder: (context, state) {
                Widget widget = const SizedBox();

                if(state.profileStateStatus == ProfileStateStatus.success){
                  widget = Text("${state.profileName}",style: textRegularStyle(context,fontSize: 18,fontWeight: FontWeight.w600),);
                }

                return widget;
              },
            ),
            AppWidgets().gapH(24),
            BlocBuilder<ProfileBloc,ProfileState>(
              builder: (context, state) {
                return _successRateContainer(context,state);
              },
            ),
            AppWidgets().gapH(24),
            // _profileOption(context,icon: Icons.settings,title: "My Account",onTap: () {},),
            // AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.manage_accounts_rounded,title: "Settings",onTap: () {
              toReplacementNamed(
                  AppRoutes.settings,
                args: PageRouteArg(
                  from: AppRoutes.dashboard,
                  isFromDashboardNav: true,
                  pageRouteType: PageRouteType.pushReplacement,
                  to: AppRoutes.settings,
                ),
              );
            },),
            AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.support_agent,title: "Support",onTap: () {},),
            AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.logout,title: "Log out",onTap: () {
              authBloc.add(Logout());
            },),
          ],
        ),
      ),
    );
  }

  _successRateContainer(BuildContext context,ProfileState? state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(boxRadius10P),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("${state?.totalGeneratedResponse.toString()}",style: textRegularStyle(context,isWhiteColor: true,fontSize: 24,fontWeight: FontWeight.bold),),
                  Text("Plans Generated",style: textRegularStyle(context,isWhiteColor: true,fontSize: 12,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            Container(
              color: AppColors.whitePure,
              width: 1,
              height: 42,
            ),
            Expanded(
              child: Column(
                children: [
                  Text("${state?.totalFavResponse.toString()}",style: textRegularStyle(context,isWhiteColor: true,fontSize: 24,fontWeight: FontWeight.bold),),
                  Text("Saved Favourites",style: textRegularStyle(context,isWhiteColor: true,fontSize: 12,fontWeight: FontWeight.w600),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _profileOption(BuildContext context,{IconData? icon,String? title = "",VoidCallback? onTap = null}) {
    return Material(
      color: AppColors.whitePure,
      borderRadius: BorderRadius.circular(boxRadius10P),
      child: InkWell(
        borderRadius: BorderRadius.circular(boxRadius10P),
        onTap:() => onTap!.call(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(icon),
                    AppWidgets().gapW8(),
                    Text("$title",style: textRegularStyle(context,fontSize: 14,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_outlined,size: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
