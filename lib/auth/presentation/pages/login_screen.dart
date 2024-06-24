import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:jong/auth/logic/cubit/auth_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_input.dart';
import 'package:jong/shared/widget/app_snackbar.dart';

import '../../../service_locator.dart';
import '../../../shared/application/cubit/application_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthCubit cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is LoginFailure) {
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
          }

          if (state is LoginSuccess) {
            getIt.get<ApplicationCubit>().setUser(state.user);
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: context.height - 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: padding16,
                ),
                child: AutofillGroup(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2),
                        Center(
                          child: Text(
                            "Log In to jong game",
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
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
                          controller: _passwordController,
                          label: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                          showEyes: true,
                          obscureText: true,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Password is required',
                            ),
                          ],
                        ),
                        const Gap(20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password",
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AppButton(
                          loading: state is LoginLoading,
                          bgColor: AppColors.primary,
                          text: "Login",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        ),
                        const Spacer(flex: 4),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Dont have an\n',
                              children: [
                                const TextSpan(text: "account ?  "),
                                TextSpan(
                                  text: "Signup",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.router
                                          .push(const RegisterRoute());
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Spacer(flex: 4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
