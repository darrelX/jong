import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_input.dart';


@RoutePage()
class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPassWordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: Text(
            "  Creer un nouveau mot de passe",
            style: context.textTheme.titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          toolbarHeight: 110.h,
        ),
        body: SafeArea(
          key: _formKey,
          child: Container(
            height: context.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppInput(
                    controller: _passWordController,
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
                  AppInput(
                    controller: _confirmPassWordController,
                    // label: 'Password',
                    hint: 'Confirmer le mot de passe',
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
                  AppButton(
                    // loading: state is LoginLoading,
                    bgColor: AppColors.primary,
                    text: "Se connecter à l'application",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _cubit.login(
                        //   phone: _phoneController.text,
                        //   password: _passwordController.text,
                        // );
                        context.router.pushAndPopUntil(
                            predicate: (route) => true, const LoginRoute());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
