import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:jong/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthCubit _cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  // final bool _isChecked = false;
  // final _networkCubit = getIt.get<NetworkCubit>();

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
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is LoginFailure) {
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
            ////////////////////////
            // getIt.get<ApplicationCubit>().setUser(state.user);
            // context.router.push(
            //   const ApplicationRoute(),
            //   // predicate: (route) => false,
            // );
            ////////////////////
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
          return Container(
            height: context.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(110.h),
                    Text(
                      "Log In",
                      style: context.textTheme.displaySmall!.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w900),
                    ),

                    Gap(20.h),
                    Text(
                      "Pour rester en contact avec nous, veuillez vous connecter avec vos informations personnelles.",
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.black.withOpacity(0.6)),
                      textAlign: TextAlign.start,
                    ),
                    Gap(90.h),
                    AppInput(
                      controller: _phoneController,
                      // label: 'Tel',
                      border: false,
                      hint: 'Numero de telephone',
                      labelColors: AppColors.black.withOpacity(0.7),
                      keyboardType: TextInputType.phone,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Numero de telephone requis',
                        ),
                        FormBuilderValidators.numeric()
                      ],
                    ),
                    Gap(20.h),
                    AppInput(
                      controller: _passwordController,
                      // label: 'Password',
                      hint: 'Mot de passe',
                      labelColors: AppColors.black.withOpacity(0.7),
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      showEyes: true,
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Mot de passe requis',
                        ),
                      ],
                    ),
                    Gap(100.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    // Align(
                    //       alignment: Alignment.bottomRight,
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           context.router.push(ForgetPasswordRoute(
                    //               title1: "Retrouver mon compte",
                    //               hasForgottenPassword: true,
                    //               title2:
                    //                   "Entrer un numero de votre whatsapp associé à votre compte",
                    //               description: "Retrouver mon compte"));
                    //         },
                    //         child: Text(
                    //           "Mot de passe oublié",
                    //           style: context.textTheme.bodySmall?.copyWith(
                    //               fontWeight: FontWeight.w900,
                    //               color: AppColors.primary),
                    //           textAlign: TextAlign.right,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Gap(50.h),
                    AppButton(
                      loading: state is LoginLoading,
                      bgColor: AppColors.primary,
                      text: "Connectez-vous",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _cubit.login(
                            phone: _phoneController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
                    Gap(40.h),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Avez vous un\n',
                          style: TextStyle(
                              color: AppColors.black.withOpacity(0.6)),
                          children: [
                            TextSpan(
                              text: "compte ?  ",
                              style: TextStyle(
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            TextSpan(
                              text: "Inscription",
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.router.push(ForgetPasswordRoute(
                                      title1: "Creer un compte",
                                      hasForgottenPassword: false,
                                      title2:
                                          "Bienvenue sur Jong, l'application pour gagner de la bière et se faire des amis autour de votre passion commune.",
                                      description:
                                          "Bienvenue dans l'application Jong"));
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
                    Gap(9.h),
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
