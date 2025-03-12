import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:ai_d_planner/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../binding/central_dependecy_injection.dart';
import '../../../../../../../core/constants/assets_constants.dart';
import '../../../../../../../core/constants/string_constants.dart';
import '../../../../../../../core/style/app_colors.dart';
import '../../../../../../../core/style/app_style.dart';
import '../../../../../../../core/utils/helper/app_helper.dart';
import '../../../../../../../core/widgets/app_widgets.dart';
import '../../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../../../core/widgets/text_field_widget.dart';
import '../../../../../../../data/models/page_route_arguments.dart';
import '../../../../../../../services/password_obscure_operation/bloc/password_obscure_ops_cubit.dart';
import '../../../../../../../services/password_obscure_operation/bloc/password_obscure_ops_state.dart';
import '../bloc/change_password_cubit.dart';
import '../bloc/change_password_state.dart';

class ChangePasswordPage extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  ChangePasswordPage(this.context,{super.key,this.pageRouteArg});

  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  FocusNode? passwordFocus = FocusNode();
  FocusNode? confirmPasswordFocus = FocusNode();

  bool? isPasswordShow,isConfirmPasswordShow;
  final passwordObscureCubit = getIt<PasswordObscureCubit>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(context,
      "Change Password",
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
    return _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _bodyWidgetTree(context,isKeyboardOpen: AppHelper().isKeyBoardVisible(context)),
    );
  }
  Widget _bodyWidgetTree(BuildContext context, {bool? isKeyboardOpen = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FormBuilder(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.password,
                style: textRegularStyle(context,
                    fontSize: 17, fontWeight: FontWeight.w700),
              ),
              AppWidgets().gapH8(),
              BlocBuilder<PasswordObscureCubit, PasswordObscureState>(
                builder: (context, state) {
                  return CustomTextFieldWidget(
                    context: context,
                    hint: StringConstants.password,
                    name: "password",
                    errorText: StringConstants.passwordError,
                    showSuffixIcon: true,
                    autoFillEnabled: false,
                    showStar: true,
                    keyboardType: KeyboardType.password,
                    isPasswordType: true,
                    controller: passwordController,
                    focusNode: passwordFocus,
                    showPassword: isPasswordShow ?? false,
                    hasCustomIcon: true,
                    showPrefixIcon: true,
                    prefixIcon: SvgPicture.asset(password,fit: BoxFit.scaleDown,),
                    onClickPasswordShowHide: () {
                      isPasswordShow = passwordObscureCubit.toggleObscureOnClick(
                          currentValue: isPasswordShow ?? false);
                    },
                  );
                },
              ),
              AppWidgets().gapH(8),
              Text(
                StringConstants.c_password,
                style: textRegularStyle(context,
                    fontSize: 17, fontWeight: FontWeight.w700),
              ),
              AppWidgets().gapH8(),
              BlocBuilder<PasswordObscureCubit, PasswordObscureState>(
                builder: (context, state) {
                  return CustomTextFieldWidget(
                    context: context,
                    hint: StringConstants.c_password,
                    name: "confirm_password",
                    errorText: StringConstants.passwordError,
                    showSuffixIcon: true,
                    autoFillEnabled: false,
                    showStar: true,
                    keyboardType: KeyboardType.password,
                    isPasswordType: true,
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocus,
                    showPassword: isConfirmPasswordShow ?? false,
                    hasCustomIcon: true,
                    showPrefixIcon: true,
                    prefixIcon: SvgPicture.asset(password,fit: BoxFit.scaleDown,),
                    onClickPasswordShowHide: () {
                      isConfirmPasswordShow = passwordObscureCubit.toggleObscureOnClick(
                          currentValue: isConfirmPasswordShow ?? false);
                    },
                  );
                },
              ),
              AppWidgets().gapH(30),

              BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ChangePasswordLoading) {
                    AppHelper().showLoader();
                  }
                  if (state is ChangePasswordSuccess) {
                    AppWidgets().getSnackBar(
                      status: SnackBarStatus.success,
                      message: "Password changed successfully",
                    );
                    AppHelper().hideLoader();

                    _onPopBackMethod();

                  } else if (state is ChangePasswordFailure) {
                    AppWidgets().getSnackBar(
                      status: SnackBarStatus.error,
                      message: state.error,
                    );
                    AppHelper().hideLoader();
                  }
                },
                builder: (context, state) {
                  return CustomAppMaterialButton(
                    title: StringConstants.signIn,
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

                        if(passwordController?.text != confirmPasswordController?.text){
                          AppWidgets().getSnackBar(
                              message: "Password not matched!",
                              status: SnackBarStatus.error
                          );
                        } else{
                          getIt<ChangePasswordCubit>().changePassword(passwordController!.text);
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        !isKeyboardOpen! ? Spacer() : SizedBox(),
      ],
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
        from: AppRoutes.changePassword,
        to: AppRoutes.settings,
        pageRouteType: PageRouteType.popped,
        isBackAction: true
      )
    );
  }
}


