import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_flutter/icons_flutter.dart';


import '../constants/local_constants.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/debounce_helper.dart';
import 'app_widgets.dart';

enum KeyboardType {
  text,
  userID,
  number,
  password,
  decimal,
  accountNumber,
  beneficiaryAccountNumber
}

//ignore: must_be_immutable
class CustomTextFieldWidget extends StatefulWidget {
  final BuildContext context;
  final String? label, hint, name;
  final bool showLabelSeparate,
      showBorder,
      isPasswordType,
      showPassword,
      showSuffixIcon,
      showPrefixIcon,
      needValidation,
      hasCustomIcon,
      isReadOnly;
  final dynamic borderColor;
  final int? borderRadius;
  final VoidCallback? onClickPasswordShowHide;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int? customHeight;
  final dynamic onChange;
  final String? errorText;
  final KeyboardType? keyboardType;
  final bool? showStar, autoFillEnabled,fieldEnable;
  final dynamic suffixIcon, prefixIcon;
  final Color? fillColor;

  CustomTextFieldWidget({
    super.key,
    required this.context,
    this.label = "",
    this.hint = "",
    this.name,
    this.isPasswordType = false,
    this.borderColor = AppColors.textGrayShade4,
    this.showBorder = true,
    this.showLabelSeparate = true,
    this.showPassword = false,
    this.onClickPasswordShowHide,
    this.customHeight = 50,
    this.borderRadius = 6,
    this.focusNode,
    this.controller = null,
    this.onChange = null,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
    this.errorText = "field cannot be empty",
    this.needValidation = true,
    this.keyboardType = KeyboardType.text,
    this.showStar = false,
    this.autoFillEnabled = false,
    this.hasCustomIcon = false,
    this.suffixIcon = null,
    this.prefixIcon = null,
    this.isReadOnly = false,
    this.fieldEnable = true,
    this.fillColor = AppColors.whitePure
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showLabelSeparate
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.label != ""
                      ? Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Row(
                            children: [
                              Text(
                                widget.label ?? "",
                                style: textRegularStyle(context,
                                    color: AppColors.blackPure),
                              ),
                              widget.showStar ?? false
                                  ? AppWidgets().gapW(4)
                                  : AppWidgets().gapH(0),
                              widget.showStar ?? false
                                  ? Text(
                                      "*",
                                      style: textRegularStyle(context,
                                          color: AppColors.warningRed),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        )
                      : AppWidgets().gapH(0),
                  widget.label != "" ? AppWidgets().gapH8() : AppWidgets().gapH(0),
                ],
              )
            : AppWidgets().gapH(0.0),
        FormBuilderField(
          name: widget.name!,
          focusNode: widget.focusNode,
          autovalidateMode: AutovalidateMode.disabled,
          validator: widget.needValidation
              ? FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: widget.errorText.toString()),
                ])
              : null,
          builder: (FormFieldState<dynamic> field) => SizedBox(
            width: double.infinity,
            // height: double.parse(customHeight.toString()),
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofillHints: widget.autoFillEnabled!
                  ? widget.isPasswordType == false
                      ? [AutofillHints.username]
                      : [AutofillHints.password]
                  : null,
              decoration: InputDecoration(
                border: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: BorderSide(
                          color: widget.borderColor,
                        ))
                    : InputBorder.none,
                enabledBorder: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: BorderSide(
                          color: widget.borderColor,
                        ))
                    : InputBorder.none,
                focusedBorder: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: BorderSide(
                          color: widget.borderColor,
                        ))
                    : InputBorder.none,
                errorBorder: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: const BorderSide(
                          color: AppColors.warningRed,
                        ))
                    : InputBorder.none,
                focusedErrorBorder: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: const BorderSide(
                          color: AppColors.warningRed,
                        ))
                    : InputBorder.none,
                disabledBorder: widget.showBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            double.tryParse(widget.borderRadius.toString())!),
                        borderSide: BorderSide(
                          color: widget.borderColor,
                        ))
                    : InputBorder.none,
                enabled: widget.fieldEnable!,
                labelText: !widget.showLabelSeparate ? '${widget.label}' : "",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                hintText: widget.hint ?? "",
                constraints: BoxConstraints(
                  maxHeight: field.errorText != null
                      ? double.parse((widget.customHeight! + 20).toString())
                      : double.parse((widget.customHeight!).toString()),
                  minHeight: double.parse(widget.customHeight.toString()),
                  // minWidth: MediaQuery.of(context).size.width,
                  // maxWidth: MediaQuery.of(context).size.width,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: !widget.fieldEnable! ? AppColors.textGrayShade4 : widget.fillColor,
                filled: !widget.fieldEnable! ? false : true,
                suffixIcon: widget.showSuffixIcon
                    ? widget.isPasswordType && widget.hasCustomIcon
                        ? IconButton(
                            onPressed: () => widget.onClickPasswordShowHide?.call(),
                            splashRadius: 5,
                            icon: widget.showPassword
                                ? Icon(
                                    Feather.eye_off,
                                    color: field.errorText != null
                                        ? AppColors.warningRed
                                        : AppColors.primaryColor
                                            .withOpacity(0.6),
                                  )
                                : Icon(
                              Feather.eye,
                                    color: field.errorText != null
                                        ? AppColors.warningRed
                                        : AppColors.primaryColor
                                            .withOpacity(0.6),
                                  ),
                          )
                        : !widget.isPasswordType && widget.hasCustomIcon
                            ? widget.suffixIcon
                            : null
                    : null,
                prefixIcon: widget.showPrefixIcon
                    ? widget.hasCustomIcon
                        ? widget.prefixIcon
                        : null
                    : null,
                counterText: "",
                error: field.errorText != null
                    ? Text(
                        // AppWidgets().globalContext.tr(field.errorText!),
                        field.errorText!,
                        style: textRegularStyle(context,
                            color: AppColors.warningRed, fontSize: 11),
                      )
                    : null,
              ),
              keyboardType: widget.keyboardType == KeyboardType.number ||
                      widget.keyboardType == KeyboardType.decimal ||
                      widget.keyboardType == KeyboardType.userID ||
                      widget.keyboardType == KeyboardType.accountNumber ||
                      widget.keyboardType == KeyboardType.beneficiaryAccountNumber
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                widget.keyboardType == KeyboardType.number
                            ? FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            : widget.keyboardType == KeyboardType.decimal
                                ? FilteringTextInputFormatter.allow(RegExp(r"^\d{0,9}[\.]?\d{0,2}"))
                                : widget.keyboardType == KeyboardType.password
                                    ? FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_\-@\.]*'))
                                        : widget.keyboardType == KeyboardType.accountNumber
                                            ? FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]*'))
                                            : FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_\-=@,\.; ]*')),

                // ? FilteringTextInputFormatter.allow(RegExp("[0-9.]")) :
                //r'^\d+\.?\d{0,2}' // digits with two decimal points

                // : FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$')),
              ],

              obscureText: (widget.isPasswordType && !widget.showPassword),
              obscuringCharacter: '\u25CF',
              style: textRegularStyle(
                context,
                color: AppColors.textColor,
                fontWeight: !widget.fieldEnable! ? FontWeight.w600 : FontWeight.normal
              ),
              readOnly: widget.isReadOnly,
              maxLines: 1,
              maxLength: widget.keyboardType == KeyboardType.number ||
                      widget.keyboardType == KeyboardType.decimal
                  ? 10
                  : 50,
              onChanged: (value) {
                DebounceHelper().killAllDebounce();
                DebounceHelper().debounce(
                    time: 250,
                    tag: DebounceHelper.textFieldDebounceTag,
                    onMethod: () {
                      if (value.isNotEmpty) {
                        field.didChange(value);
                        field.save();
                        if (widget.needValidation) {
                          field.validate();
                        }
                        if (widget.onChange != null) {
                          widget.onChange(value);
                        }
                      } else {
                        field.didChange("");
                        field.save();
                      }
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}


//ignore: must_be_immutable
class CustomPinFiledWidget extends StatefulWidget {

  final TextEditingController? textEditingController;
  final BuildContext? context;
  final String? label, hint, name, errorText;
  final bool showLabelSeparate,showBorder;
  final bool showStar,needValidation;
  final FocusNode? focusNode;
  final int? borderRadius,pinLength;
  final dynamic onChange;
  final dynamic borderColor;

  CustomPinFiledWidget({super.key,
    this.textEditingController,
    this.context,
    this.label,
    this.hint,
    this.name,
    this.showLabelSeparate = true,
    this.showStar = false,
    this.focusNode,
    this.needValidation = true,
    this.errorText,
    this.onChange,
    this.borderRadius = 6,
    this.showBorder = true,
    this.borderColor = AppColors.textGrayShade4,
    this.pinLength = 4
  });

  @override
  State<CustomPinFiledWidget> createState() => _CustomPinFiledWidgetState();
}

class _CustomPinFiledWidgetState extends State<CustomPinFiledWidget> {
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.showLabelSeparate
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.label != ""
                ? Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: widget.label ?? "",
                        children: [
                          widget.showStar ? TextSpan(
                              text: " *",
                            style: textRegularStyle(context,
                                color: AppColors.warningRed),
                          ) : TextSpan(text: "")
                        ]
                      ),
                      style: textRegularStyle(context,
                          color: AppColors.blackPure),
                    ),
                  ),
                  // widget.showStar ?? false
                  //     ? AppWidgets().gapW(4)
                  //     : AppWidgets().gapH(0),
                  // widget.showStar ?? false
                  //     ? Text(
                  //   "*",
                  //   style: textRegularStyle(context,
                  //       color: AppColors.warningRed),
                  // )
                  //     : const SizedBox()
                ],
              ),
            )
                : AppWidgets().gapH(0),
            widget.label != "" ? AppWidgets().gapH8() : AppWidgets().gapH(0),
          ],
        ) : AppWidgets().gapH(0.0),

        FormBuilderField(
          name: widget.name!,
          focusNode: widget.focusNode,
          autovalidateMode: AutovalidateMode.disabled,
          validator: widget.needValidation
              ? FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: widget.errorText.toString()),
          ])
              : null,
          builder: (FormFieldState<dynamic> field) => TextField(
            focusNode: widget.focusNode,
            controller: controller,
            obscureText: true,
            obscuringCharacter: '●',
            maxLength: widget.pinLength,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            style: textRegularStyle(
              context,
              color: AppColors.textColor,
            ),
            inputFormatters: <TextInputFormatter>[
              ObscuredPINFormatter(actualController: widget.textEditingController,pinMaxLength: widget.pinLength,),
            ],
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: BorderSide(
                    color: widget.borderColor,
                  ))
                  : InputBorder.none,
              enabledBorder: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: BorderSide(
                    color: widget.borderColor,
                  ))
                  : InputBorder.none,
              focusedBorder: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: BorderSide(
                    color: widget.borderColor,
                  ))
                  : InputBorder.none,
              errorBorder: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: const BorderSide(
                    color: AppColors.warningRed,
                  ))
                  : InputBorder.none,
              focusedErrorBorder: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: const BorderSide(
                    color: AppColors.warningRed,
                  ))
                  : InputBorder.none,
              disabledBorder: widget.showBorder
                  ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      double.tryParse(widget.borderRadius.toString())!),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                  ))
                  : InputBorder.none,
              enabled: true,
              labelText: !widget.showLabelSeparate ? '${widget.label}' : "",
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              counterText: '',
              hintText: widget.hint ?? "",
              hintStyle: textRegularStyle(
                context,
                fontSize: 13,
              ),
              error: field.errorText != null
                  ? Text(
                AppWidgets().globalContext.tr(field.errorText!),
                style: textRegularStyle(context,
                    color: AppColors.warningRed, fontSize: 11),
              ) : null,
            ),
            onChanged: (value) {
              DebounceHelper().killAllDebounce();
              DebounceHelper().debounce(
                  time: 250,
                  tag: DebounceHelper.textFieldDebounceTag,
                  onMethod: () {
                    if (value.isNotEmpty) {
                      field.didChange(value);
                      field.save();
                      if (widget.needValidation) {
                        field.validate();
                      }
                      if (widget.onChange != null) {
                        widget.onChange(value);
                      }
                    } else {
                      field.didChange("");
                      field.save();
                    }
                  });
            },
          ),
        ),
      ],
    );
  }
}

class ObscuredPINFormatter extends TextInputFormatter {
  final TextEditingController? actualController;
  final int? pinMaxLength;
  String _actualText = '';

  // Constructor to accept the actual controller
  ObscuredPINFormatter({this.actualController,this.pinMaxLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text.length < oldValue.text.length) {
      // Handle deletion: Trim the actual text
      // printLog("Character reducing");
      _actualText = _actualText.substring(0, newValue.text.length);
    }

    else {
      // Handle addition: Append only the new characters
      // printLog("Character Append");

      final allowedPattern = RegExp(r'^[0-9]');

      if(!allowedPattern.hasMatch(newValue.text[newValue.text.length - 1])){
        return oldValue;
      }

      else{
        final filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

        // _actualText += filteredText.isNotEmpty ? filteredText : '';
        if (_actualText.length < (pinMaxLength ?? 4)) {
          //_actualText += filteredText.substring(0, ((pinMaxLength ?? 4) - _actualText.length).clamp(0, filteredText.length));
          _actualText = actualController!.value.text + (filteredText.isNotEmpty ? filteredText : '');
        }
      }
    }

    // Replace the actual characters with the obscured text character (●)
    String obscuredText = '●' * _actualText.length;

    // Store the actual text in the secondary controller
    actualController?.value = TextEditingValue(
      text: _actualText,
      selection: TextSelection.collapsed(offset: obscuredText.length),
    );

    // Return the obscured text to be displayed
    return TextEditingValue(
      text: obscuredText, // Show only '●' characters
      selection: TextSelection.collapsed(offset: obscuredText.length), // Keep the cursor at the end
    );
  }
}

class CustomAccountIDTextFieldWidget extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  CustomAccountIDTextFieldWidget(
      {super.key, this.formKey, this.controller, this.focusNode});

  @override
  State<CustomAccountIDTextFieldWidget> createState() =>
      _CustomAccountIDTextFieldWidgetState();
}

class _CustomAccountIDTextFieldWidgetState extends State<CustomAccountIDTextFieldWidget> {
  TextEditingController? branchCodeController = TextEditingController();
  TextEditingController? masterIDController = TextEditingController();
  TextEditingController? productTypeController = TextEditingController();
  TextEditingController? userAccountNoController = TextEditingController();

  FocusNode? branchCodeFocusNode = FocusNode();
  FocusNode? masterIDFocusNode = FocusNode();
  FocusNode? productTypeFocusNode = FocusNode();
  FocusNode? userAccountNoFocusNode = FocusNode();

  int? branchCodeValidation = -1;
  int? masterIDValidation = -1;
  int? productTypeValidation = -1;
  int? userAccountNoValidation = -1;

  //-1 is for no action
  //0 is for required field
  // 1 is for invalid account ID

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: () {
        getAllFieldData();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Row(
              children: [
                Text(
                  "Enter Account Number",
                  style: textRegularStyle(context, color: AppColors.blackPure),
                ),
                AppWidgets().gapW(4),
                Text(
                  "*",
                  style: textRegularStyle(context, color: AppColors.warningRed),
                )
              ],
            ),
          ),
          AppWidgets().gapH8(),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: branchCodeController,
                    focusNode: branchCodeFocusNode,
                    textAlign: TextAlign.center,
                    maxLength: 3,
                    decoration:
                        inputDecoration(validationValue: branchCodeValidation),
                    inputFormatters: getInputFormatter(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 3) {
                        branchCodeFocusNode?.unfocus();
                        masterIDFocusNode?.requestFocus();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            branchCodeValidation = 0;
                          });
                        });
                      } else if (value.length < 3) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            branchCodeValidation = 1;
                          });
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            branchCodeValidation = -1;
                          });
                        });
                      }
                      return null;
                    },
                  )),
              AppWidgets().gapW8(),
              _getDash(context),
              AppWidgets().gapW8(),
              Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: masterIDController,
                    focusNode: masterIDFocusNode,
                    textAlign: TextAlign.center,
                    maxLength: 5,
                    decoration:
                        inputDecoration(validationValue: masterIDValidation),
                    inputFormatters: getInputFormatter(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 4 || value.length == 5) {
                        masterIDFocusNode?.unfocus();
                        productTypeFocusNode?.requestFocus();
                      } else if (value.isEmpty) {
                        masterIDFocusNode?.unfocus();
                        branchCodeFocusNode?.requestFocus();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            masterIDValidation = 0;
                          });
                        });
                      } else if (value.length < 4) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            masterIDValidation = 1;
                          });
                        });
                      } else if (value.length == 4 || value.length == 5) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            masterIDValidation = -1;
                          });
                        });
                      }
                      return null;
                    },
                  )),
              AppWidgets().gapW8(),
              _getDash(context),
              AppWidgets().gapW8(),
              Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: productTypeController,
                    focusNode: productTypeFocusNode,
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    decoration:
                        inputDecoration(validationValue: productTypeValidation),
                    inputFormatters: getInputFormatter(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 2) {
                        productTypeFocusNode?.unfocus();
                        userAccountNoFocusNode?.requestFocus();
                      } else if (value.isEmpty) {
                        productTypeFocusNode?.unfocus();
                        masterIDFocusNode?.requestFocus();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            productTypeValidation = 0;
                          });
                        });
                      } else if (value.length == 1) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            productTypeValidation = 1;
                          });
                        });
                      } else if (value.length == 2) {
                        if (value.toString() == "10" ||
                            value.toString() == "49") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              productTypeValidation = -1;
                            });
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              productTypeValidation = 1;
                            });
                          });
                        }
                      }
                      return null;
                    },
                  )),
              AppWidgets().gapW8(),
              _getDash(context),
              AppWidgets().gapW8(),
              Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: userAccountNoController,
                    focusNode: userAccountNoFocusNode,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    decoration: inputDecoration(
                        validationValue: userAccountNoValidation),
                    inputFormatters: getInputFormatter(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        userAccountNoFocusNode?.unfocus();
                        productTypeFocusNode?.requestFocus();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            userAccountNoValidation = 0;
                          });
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            userAccountNoValidation = -1;
                          });
                        });
                      }
                      return null;
                    },
                  )),
            ],
          ),
          AppWidgets().gapH(6),
          branchCodeValidation! == 1 ||
                  masterIDValidation! == 1 ||
                  productTypeValidation! == 1 ||
                  userAccountNoValidation! == 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    "Invalid Account Number!",
                    style: textRegularStyle(context,
                        color: AppColors.warningRed, fontSize: 11),
                  ),
                )
              : branchCodeValidation! == 0 ||
                      masterIDValidation! == 0 ||
                      productTypeValidation! == 0 ||
                      userAccountNoValidation! == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "Required Field",
                        style: textRegularStyle(context,
                            color: AppColors.warningRed, fontSize: 11),
                      ),
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }

  inputDecoration({validationValue}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(double.tryParse("6")!),
            borderSide: BorderSide(
              color: validationValue == -1
                  ? AppColors.textGrayShade4
                  : AppColors.warningRed,
            )),
        enabled: true,
        constraints: BoxConstraints(maxHeight: 40, minHeight: 40),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        // labelText: !showLabelSeparate ? '$label' : "",
        // hintText: hint ?? "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: "");
  }

  getInputFormatter() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
    ];
  }

  _getDash(BuildContext? context) {
    return Text(
      "-",
      style:
          textRegularStyle(context, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  getAllFieldData() {
    widget.controller!.text =
        "${branchCodeController?.value.text.toString()}-${masterIDController?.value.text.toString()}-${productTypeController?.value.text.toString()}-${userAccountNoController?.value.text.toString()}";
  }
}

