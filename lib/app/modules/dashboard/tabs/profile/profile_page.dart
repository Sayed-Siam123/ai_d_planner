import 'dart:io';

import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/helper/app_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            AppWidgets().gapH(40),
            Image.asset(profilePicDummy,height: 80,),
            AppWidgets().gapH(16),
            Text("Leslie Alex",style: textRegularStyle(context,fontSize: 18,fontWeight: FontWeight.w600),),
            AppWidgets().gapH(24),
            _successRateContainer(context),
            AppWidgets().gapH(24),
            _profileOption(context,icon: Icons.settings,title: "My Account",onTap: () {},),
            AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.manage_accounts_rounded,title: "Setting",onTap: () {},),
            AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.support_agent,title: "Support",onTap: () {},),
            AppWidgets().gapH(12),
            _profileOption(context,icon: Icons.logout,title: "Log out",onTap: () {},),
          ],
        ),
      ),
    );
  }

  _successRateContainer(BuildContext context) {
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
                  Text("122",style: textRegularStyle(context,isWhiteColor: true,fontSize: 24,fontWeight: FontWeight.bold),),
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
                  Text("92%",style: textRegularStyle(context,isWhiteColor: true,fontSize: 24,fontWeight: FontWeight.bold),),
                  Text("Success Ratio",style: textRegularStyle(context,isWhiteColor: true,fontSize: 12,fontWeight: FontWeight.w600),)
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
