import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jong/auth/logic/cubit/auth_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_input.dart';
import 'package:jong/shared/widget/app_snackbar.dart';
import 'package:jong/shared/widget/button.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://cdc4-145-224-75-85.ngrok-free.app/api/auth/google',
    ],
  );
  @override
  void initState() {
    super.initState();
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   // Utilisateur connecté
    //   if (account != null) {
    //     // Gérer l'authentification réussie ici
    //     print('Utilisateur connecté : ${account.displayName}');
    //   }
    // } as void Function(GoogleSignInAccount? event)?);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Erreur lors de la connexion Google : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          "  Log In",
          style: context.textTheme.headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        toolbarHeight: 60.h,
        // centerTitle: true,
      ),
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
          return SingleChildScrollView(
            child: Container(
              height: context.height - 80.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(40.h),
                      Text(
                        "Welcome Back!",
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),
                      Text(
                        "To keep connected with us please login with your personal info",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Gap(40.h),
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
                      Gap(20.h),
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
                      Gap(20.h),
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
                      Gap(50.h),
                      AppButton(
                        loading: state is LoginLoading,
                        bgColor: AppColors.primary,
                        text: "Login",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _cubit.login(
                              phone: _phoneController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                      Gap(80.h),
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
                                    context.router.push(const RegisterRoute());
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
                      // Gap(4.h),
                    ],
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
