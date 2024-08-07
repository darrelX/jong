import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneNumber? number;
  String pm = 'momo';

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
    final bloc = getIt.get<ApplicationCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Popup account"),
      ),
      body: BlocBuilder<ApplicationCubit, ApplicationState>(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: padding16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Gap(20.h),
                        Text(
                          "Enter Your Phone Number",
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: 28.sp,
                          ),
                        ),
                        Gap(30.h),
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
                          initialValue: PhoneNumber(isoCode: 'CM'),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                            setSelectorButtonAsPrefixIcon: true,
                            leadingPadding: 10,
                          ),
                          inputDecoration: InputDecoration(
                            contentPadding: context
                                .theme.inputDecorationTheme.contentPadding,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: _phoneController,
                          formatInput: true,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder:
                              context.theme.inputDecorationTheme.border,
                        ),
                        Gap(40.h),
                        AppInput(
                          controller: _amountController,
                          label: 'Amount',
                          keyboardType: TextInputType.number,
                          width: 350.w,
                          suffixIcon: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("fcfa"),
                            ],
                          ),
                          autoValidate: AutovalidateMode.onUserInteraction,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            (value) {
                              if (value != null && value.isNotEmpty) {
                                final number = int.tryParse(value);
                                if (number == 0) {
                                  return 'Le nombre doit être supérieur à 0';
                                }
                                if ((number != null && number % 5 != 0)) {
                                  return 'Le nombre doit être un multiple de 5.';
                                }
                              }
                              return null;
                            },
                          ],
                        ),
                        const Gap(20),
                        RadioListTile<String>(
                          value: 'mtn',
                          groupValue: pm,
                          onChanged: (value) {
                            // if (value == null) return;
                            setState(() {
                              pm = value!;
                            });
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mobile Money",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Image.asset(
                                "assets/images/momo.jpeg",
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                        ),
                        RadioListTile<String>(
                          value: 'orange',
                          groupValue: pm,
                          onChanged: (value) {
                            // if (value == null) return;
                            setState(() {
                              pm = value!;
                            });
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Orange Money",
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await bloc.deposit(
                            pm,
                            int.parse(_amountController.value.text),
                            state.user!.id!);
                        if (!context.mounted) return;
                        context.router.pushAndPopUntil(const HomeRoute(),
                            predicate: (route) => false);
                      }
                    },
                    bgColor: AppColors.primary,
                    text: 'Top up my account',
                  ),
                  const Gap(8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
