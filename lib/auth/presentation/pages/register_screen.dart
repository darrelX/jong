import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/widget/app_bottom_sheet.dart';

import '../../../service_locator.dart';
import '../../../shared/application/cubit/application_cubit.dart';
import '../../../shared/routing/app_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_input.dart';
import '../../../shared/widget/app_snackbar.dart';
import '../../logic/cubit/auth_cubit.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String pwd = '';
  int gender = 1;

  final AuthCubit _cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text("sign in"),
        centerTitle: true,
        toolbarHeight: 60.h,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is RegisterFailure) {
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
          }

          if (state is RegisterSuccess) {
            getIt.get<ApplicationCubit>().setUser(state.user);
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              padding: EdgeInsets.symmetric(horizontal: 19.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(20.h),
                    Center(
                      child: Text(
                        "Sign In to jong game",
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _nameController,
                      label: 'Name',
                      keyboardType: TextInputType.name,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Name is required',
                        )
                      ],
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _emailController,
                      label: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [
                        AutofillHints.email,
                      ],
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'E-mail is required',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'E-mail is required',
                        ),
                      ],
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _phoneController,
                      label: 'Tel',
                      keyboardType: TextInputType.phone,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Phone number is required',
                        ),
                      ],
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _genderController,
                      label: 'Gender',
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      onTap: () {
                        AppBottomSheet.showModelBottomSheet(
                          context: context,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text("Male"),
                                selected: gender == 1,
                                onTap: () {
                                  setState(() {
                                    gender = 1;
                                    _genderController.text = "Male";
                                    context.router.maybePop();
                                  });
                                },
                              ),
                              ListTile(
                                title: const Text("Female"),
                                selected: gender == 0,
                                onTap: () {
                                  setState(() {
                                    gender = 0;
                                    _genderController.text = "Female";
                                    context.router.maybePop();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Gender is required',
                        ),
                      ],
                      suffixIcon:
                          const Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _passwordController,
                      label: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      showEyes: true,
                      onChange: (value) {
                        pwd = value;
                        setState(() {});
                      },
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Password is required',
                        ),
                      ],
                    ),
                    Gap(18.h),
                    AppInput(
                      controller: _confirmPasswordController,
                      label: 'Confirm password',
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      showEyes: true,
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Field is required',
                        ),
                        FormBuilderValidators.equal(
                          pwd,
                          errorText: 'Does not match',
                        )
                      ],
                    ),
                    Gap(18.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding16,
                      ),
                      child: AppButton(
                        loading: state is RegisterLoading,
                        bgColor: AppColors.primary,
                        text: "Sign In",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _cubit.register(
                              name: _nameController.text,
                              email: _emailController.text,
                              birthDate: DateTime.now(),
                              gender: gender,
                              phoneNumber: _phoneController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
