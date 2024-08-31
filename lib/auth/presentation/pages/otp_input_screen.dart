import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../topup/widgets/validation_payement_widget.dart';

class OTPInputScreen extends StatefulWidget {
  const OTPInputScreen({super.key});

  @override
  State createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OTPInputScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String currentText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose;
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
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: Colors.white),
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(80.h),
              Text(
                'We have send a code to\nyour whatsApp enter it here',
                style: context.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Gap(140.h),
              SizedBox(
                width: 250.w,
                // height: 200.h,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 90.h,
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
                  controller: _textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              Gap(20.h),
              Text(
                'Enter OTP',
                style: context.textTheme.titleMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              Gap(160.h),
              AppButton(
                  // loading: state is RegisterLoading,
                  bgColor: AppColors.primary,
                  text: "Sign In",
                  onPressed: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
