import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_input.dart';

@RoutePage()
class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  PhoneNumber? number;
  var pm = 'momo';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popup acount"),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: padding16,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Gap(context.padding.top),
                  Text(
                    "Enter Your Phone Number",
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 28.sp,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Phone number",
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const Gap(6),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber value) {
                      number = value;
                      setState(() {});
                    },
                    hintText: '',
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
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: _phoneController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: context.theme.inputDecorationTheme.border,
                  ),
                  const Gap(20),
                  AppInput(
                    controller: _amountController,
                    label: 'Amount',
                    keyboardType: TextInputType.number,
                    suffixIcon: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("fcfa"),
                      ],
                    ),
                  ),
                  const Gap(20),
                  RadioListTile<String>(
                    value: 'mtn',
                    groupValue: pm,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        pm = value;
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mobile money",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          "assets/images/momo.jpeg",
                          width: 55,
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  RadioListTile<String>(
                    value: 'orange',
                    groupValue: pm,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        pm = value;
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Orange money",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          "assets/images/om.jpeg",
                          width: 40,
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            AppButton(
              onPressed: () {},
              bgColor: AppColors.primary,
              text: 'Top up my account',
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
