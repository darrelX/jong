import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';

@RoutePage()
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  PhoneNumber? _number;

  // final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          "  Retrouver mon compte",
          style: context.textTheme.titleLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        toolbarHeight: 110.h,
      ),
      body: Container(
        height: context.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Gap(60.h),
                Text(
                  "Retrouver mon compte",
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(100.h),
                Text(
                  "Entrer un numero de votre whatsapp associé à votre compte",
                  style: context.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(100.h),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber value) {
                    setState(() {
                      _number = value;
                    });
                  },
                  hintText: '',
                  initialValue: PhoneNumber(isoCode: 'CM'),
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    useBottomSheetSafeArea: true,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 10,
                  ),
                  inputDecoration: InputDecoration(
                    contentPadding:
                        context.theme.inputDecorationTheme.contentPadding,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  textFieldController: _phoneController,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: context.theme.inputDecorationTheme.border,
                ),
                // _number!.
                Gap(200.h),
                AppButton(
                  // loading: state is LoginLoading,
                  bgColor: AppColors.primary,
                  text: "Retrouver mon compte",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(_number);
                      // _cubit.login(
                      //   phone: _phoneController.text,
                      //   password: _passwordController.text,
                      // );
                      context.router.pushAndPopUntil(
                          predicate: (route) => true,
                          OTPInputRoute(number: _phoneController.value.text));
                    }
                  },
                ),
                Gap(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
