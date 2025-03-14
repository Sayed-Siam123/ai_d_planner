import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/constants/assets_constants.dart';
import '../../../../../../../core/constants/string_constants.dart';
import '../../../../../../../core/style/app_colors.dart';
import '../../../../../../../core/style/app_style.dart';
import '../../../../../../../core/widgets/app_widgets.dart';
import '../../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../../../core/widgets/text_field_widget.dart';
import '../../../../../../../data/models/page_route_arguments.dart';
import '../../../../../../../routes/app_pages.dart';
import '../../../../../../../routes/app_routes.dart';

class ChangeUserNamePage extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  ChangeUserNamePage(this.context,{super.key,this.pageRouteArg});

  TextEditingController? userNameController = TextEditingController();
  FocusNode? userNameFocus = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(context,
      "Update Name",
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
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringConstants.name,
              style: textRegularStyle(context,
                  fontSize: 17, fontWeight: FontWeight.w700),
            ),
            AppWidgets().gapH(30),
            CustomTextFieldWidget(
              context: context,
              hint: StringConstants.name,
              name: "name",
              errorText: StringConstants.nameError,
              isPasswordType: false,
              showStar: true,
              keyboardType: KeyboardType.text,
              showSuffixIcon: false,
              autoFillEnabled: false,
              controller: userNameController,
              focusNode: userNameFocus,
              isReadOnly: false,
              fieldEnable: true,
              fillColor: AppColors.whitePure,
              borderColor: AppColors.textFieldBorderColor,
              hasCustomIcon: true,
              showPrefixIcon: true,
              prefixIcon: SvgPicture.asset(user,fit: BoxFit.scaleDown,),
            ),
            AppWidgets().gapH(30),
            CustomAppMaterialButton(
              title: "Update",
              backgroundColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
              usePrefixIcon: false,
              needSplashEffect: true,
              borderRadius: 50,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  getIt<ProfileBloc>().add(UpdateNameData(username: userNameController?.text.toString()));
                }
              },
            ),
          ],
        ),
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
    back(
        pageRouteArgs: PageRouteArg(
            from: AppRoutes.changeUserName,
            to: AppRoutes.settings,
            pageRouteType: PageRouteType.popped,
            isBackAction: true
        )
    );
  }
  
}


