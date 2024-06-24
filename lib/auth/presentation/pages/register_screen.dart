import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final  TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String pwd = '';
  int gender = 1;

  final AuthCubit cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sign in"),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
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
          return AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding16,
                      ),
                      children: [
                        const Gap(10),
                        Center(
                          child: Text(
                            "Sign In to jong game",
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(30),
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
                        const Gap(20),
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
                        const Gap(20),
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
                        const Gap(20),
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
                        const Gap(20),
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
                        const Gap(20),
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
                        const Gap(30),
                      ],
                    ),
                  ),
                  const Gap(8),
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
                          cubit.register(
                            username: _nameController.text,
                            email: _emailController.text,
                            birthDate: DateTime.now(),
                            gender: gender,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
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
