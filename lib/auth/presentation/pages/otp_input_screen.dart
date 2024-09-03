import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../topup/widgets/validation_payement_widget.dart';

@RoutePage()
class OTPInputScreen extends StatefulWidget {
  final String? number;

  const OTPInputScreen({super.key, required this.number});

  @override
  State createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OTPInputScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String? _currentText;
  final GlobalKey<FormState> _formField = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  String? _error;
  String _secretCode = "0000";
  Timer? _timeOut;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          "  Pass Code",
          style: context.textTheme.displaySmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        toolbarHeight: 110.h,
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formField,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white),
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            height: context.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Gap(30.h),
                  Text(
                    'OTP Verification',
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Gap(60.h),
                  Text(
                    'Nous avons envoyé un code au numero whatsApp ${widget.number!.split(' ').join().substring(0, 3)}*****${widget.number!.split(' ').join().substring(8)}',
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Gap(100.h),
                  Text(
                    'Entrer le code OTP',
                    style: context.textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  Gap(40.h),
                  SizedBox(
                    width: 250.w,
                    // height: 0.h,
                    child: Column(
                      children: [
                        PinCodeTextField(
                          appContext: context,
                          length: 4,
                          autoDisposeControllers: false,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 80.h,
                            fieldWidth: 50.w,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeColor: const Color(0xFFCD6E24),
                            inactiveColor: const Color(0xFFCD6E24),
                            selectedColor: const Color(0xFFCD6E24),
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _textEditingController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onCompleted: (v) {
                            print("Completed");
                          },
                          focusNode: _focusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            setState(() {
                              _currentText = value;
                              print("currentx $_currentText");
                            });
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                        _error == null
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Text(_error!,
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w800)
                                      // textAlign: TextAlign.left,
                                      ),
                                  const Spacer(),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Gap(140.h),
                  AppButton(
                      bgColor: AppColors.primary,
                      text: "Envoyer le code OTP",
                      onPressed: () {
                        if (_formField.currentState!.validate()) {
                          print(_currentText);
                          if (_currentText == null ||
                              _currentText!.length != 4) {
                            setState(() {
                              _error = "Veuillez remplir le champ";
                            });
                            return;
                          } else if (_currentText != _secretCode) {
                            setState(() {
                              _error = "Code incorrect";
                            });
                          } else {
                            setState(() {
                              _error = null;
                            });
                          }
                        }
                        // AppDialog.showDialog(
                        //     context: context,
                        //     child: const ValidationPayementWidget());
                        // _cubit.register(
                        //   name: _nameController.text,
                        //   email: _emailController.text,
                        //   birthDate: DateTime.now(),
                        //   gender: gender,
                        //   phoneNumber: _phoneController.text,
                        //   password: _passwordController.text,
                        // );
                      }),
                  Visibility(
                    visible: false,
                    child: AppButton(
                        bgColor: AppColors.black,
                        text: "Renvoyer OTP",
                        onPressed: () {
                          if (_formField.currentState!.validate()) {}
                          // AppDialog.showDialog(
                          //     context: context,
                          //     child: const ValidationPayementWidget());
                          // _cubit.register(
                          //   name: _nameController.text,
                          //   email: _emailController.text,
                          //   birthDate: DateTime.now(),
                          //   gender: gender,
                          //   phoneNumber: _phoneController.text,
                          //   password: _passwordController.text,
                          // );
                        }),
                  ),
                  Gap(20.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
