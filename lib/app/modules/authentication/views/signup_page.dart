import 'dart:io';

import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../../../core/utils/helper/app_helper.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../data/models/page_route_arguments.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';
import '../../../services/password_obscure_operation/bloc/password_obscure_ops_cubit.dart';
import '../../../services/password_obscure_operation/bloc/password_obscure_ops_state.dart';

class SignupPage extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  SignupPage(this.context,{super.key,this.pageRouteArg});

  TextEditingController? userController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();

  FocusNode? userFocus = FocusNode();
  FocusNode? emailFocus = FocusNode();
  FocusNode? passwordFocus = FocusNode();
  FocusNode? confirmPasswordFocus = FocusNode();

  bool? isPasswordShow,isConfirmPasswordShow;
  final passwordObscureCubit = getIt<PasswordObscureCubit>();
  final authBloc = getIt<AuthenticationBloc>();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.noAppBar(
      navBarColor: Platform.isAndroid
          ? AppColors.backgroundColor
          : AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return _bodyWidget(context);
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
    // TODO: implement onPopBack
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.signup,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
      isBackAction: true
    ));
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _bodyWidgetTree(context,isKeyboardOpen: AppHelper().isKeyBoardVisible(context)),
    );
  }
  Widget _bodyWidgetTree(BuildContext context, {bool? isKeyboardOpen = false}){
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppWidgets().gapH(16),
          Center(
              child: Image.asset(
                loginLogo,
                height: 60,
                width: 60,
              )),
          AppWidgets().gapH(30),
          Text(
            StringConstants.signUp,
            style: textRegularStyle(context,
                fontSize: 25, fontWeight: FontWeight.w700),
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
            controller: userController,
            focusNode: userFocus,
            isReadOnly: false,
            fieldEnable: true,
            fillColor: AppColors.whitePure,
            borderColor: AppColors.textFieldBorderColor,
            hasCustomIcon: true,
            showPrefixIcon: true,
            prefixIcon: SvgPicture.asset(user,fit: BoxFit.scaleDown,),
          ),
          AppWidgets().gapH(8),
          CustomTextFieldWidget(
            context: context,
            hint: StringConstants.email,
            name: "email",
            errorText: StringConstants.emailError,
            isPasswordType: false,
            showStar: true,
            keyboardType: KeyboardType.text,
            showSuffixIcon: false,
            autoFillEnabled: false,
            controller: emailController,
            focusNode: emailFocus,
            isReadOnly: false,
            fieldEnable: true,
            fillColor: AppColors.whitePure,
            borderColor: AppColors.textFieldBorderColor,
            hasCustomIcon: true,
            showPrefixIcon: true,
            prefixIcon: SvgPicture.asset(email,fit: BoxFit.scaleDown,),
          ),
          AppWidgets().gapH(8),
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
          CustomAppMaterialButton(
            title: StringConstants.signUp,
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
                if(passwordController?.text.toString() != confirmPasswordController?.text.toString()){
                  AppWidgets().getSnackBar(message: "Password not matched!",status: SnackBarStatus.error);
                } else{

                  CustomerInfo customerInfo = await Purchases.getCustomerInfo();

                  authBloc.add(InitiateSignup(
                    email: emailController?.text.toString(),
                    password: passwordController?.text.toString(),
                    userName: userController?.text.toString(),
                    rcAppOriginalID: customerInfo.originalAppUserId
                  ));
                }
              }
            },
          ),
          AppWidgets().gapH(30),
          // !isKeyboardOpen! ? Spacer() : SizedBox(),
          !isKeyboardOpen! ? Text.rich(TextSpan(
              text: StringConstants.alreadyHaveAnyAccount,
              style: textRegularStyle(context, fontWeight: FontWeight.w500),
              children: [
                TextSpan(text: " "),
                TextSpan(
                  text: StringConstants.signIn,
                  style: textRegularStyle(context,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700)
                      .copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _tapOnSignIn();
                    },
                )
              ])) : SizedBox(),
          !isKeyboardOpen ? AppWidgets().gapH(10) : SizedBox(),
        ],
      ),
    );
  }

  void _tapOnSignIn() {
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.signup,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
      isBackAction: true
    ));
  }
}
