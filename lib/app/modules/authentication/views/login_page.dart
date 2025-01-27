import 'dart:io';

import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_event.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/utils/helper/app_helper.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../routes/app_routes.dart';
import '../../../services/password_obscure_operation/bloc/password_obscure_ops_cubit.dart';
import '../../../services/password_obscure_operation/bloc/password_obscure_ops_state.dart';

class LoginPage extends BaseView {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  LoginPage(this.context, {super.key, this.pageRouteArg});

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  FocusNode? emailFocus = FocusNode();
  FocusNode? passwordFocus = FocusNode();
  bool? isPasswordShow;
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
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  _socialMediaLogoWidget(logo) {
    return InkWell(
      onTap: () {

      },
      borderRadius: BorderRadius.circular(boxRadius),
      child: Container(
        height: 70,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(boxRadius),
        ),
        child: SvgPicture.asset(logo),
      ),
    );
  }

  _orWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 126,
          color: AppColors.blackPure,
        ),
        AppWidgets().gapW(7),
        Text(StringConstants.or.toLowerCase(),
            style: textRegularStyle(context,
                fontSize: 16, fontWeight: FontWeight.w500)),
        AppWidgets().gapW(7),
        Container(
          height: 0.5,
          width: 126,
          color: AppColors.blackPure,
        ),
      ],
    );
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
            children: [
              AppWidgets().gapH(32),
              Center(
                  child: Image.asset(
                    loginLogo,
                    height: 60,
                    width: 60,
                  )),
              AppWidgets().gapH(30),
              Text(
                StringConstants.loginOrSignup,
                style: textRegularStyle(context,
                    fontSize: 25, fontWeight: FontWeight.w700),
              ),
              AppWidgets().gapH(30),
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
              Align(
                alignment: Alignment.centerRight,
                child: CustomAppTextButton(
                    onPressed: () {},
                    title: StringConstants.f_password,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.primaryColor
                ),
              ),
              AppWidgets().gapH(30),
              CustomAppMaterialButton(
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
                    authBloc.add(InitiateLogin(
                      email: emailController?.value.text,
                      password: passwordController?.value.text
                    ));
                  }
                },
              ),
              AppWidgets().gapH(40),
              _orWidget(),
              AppWidgets().gapH(15),
              Text(
                StringConstants.signInWith,
                style: textRegularStyle(context,
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              AppWidgets().gapH(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialMediaLogoWidget(appleLogo),
                  AppWidgets().gapW24(),
                  _socialMediaLogoWidget(fbLogo),
                  AppWidgets().gapW24(),
                  _socialMediaLogoWidget(googleLogo),
                ],
              ),
            ],
          ),
        ),
        !isKeyboardOpen! ? Spacer() : SizedBox(),
        !isKeyboardOpen ? Text.rich(TextSpan(
            text: StringConstants.dontHaveAnyAccount,
            style: textRegularStyle(context, fontWeight: FontWeight.w500),
            children: [
              TextSpan(text: " "),
              TextSpan(
                text: StringConstants.signUp,
                style: textRegularStyle(context,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700)
                    .copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _tapOnSignup();
                  },
              )
            ])) : SizedBox(),
        !isKeyboardOpen ? AppWidgets().gapH(10) : SizedBox(),
      ],
    );
  }

  void _tapOnSignup() {
    toReplacementNamed(AppRoutes.signup,args: PageRouteArg(
      to: AppRoutes.signup,
      from: AppRoutes.login,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
    ));
  }
}
