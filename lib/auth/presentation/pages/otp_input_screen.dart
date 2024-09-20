import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/auth/logic/otp_cubit/otp_bloc.dart';
import 'package:jong/auth/presentation/widgets/pin_code_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';

@RoutePage()
class OTPInputScreen extends StatefulWidget {
  final String? number;
  final bool hasForgottenPassword;

  const OTPInputScreen(
      {super.key, required this.number, this.hasForgottenPassword = true});

  @override
  State createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OTPInputScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String? _currentText;
  final GlobalKey<FormState> _formField = GlobalKey<FormState>();
  String? _error;
  final String _secretCode = "0000";
  bool _isExpired = false;

  late final OtpBloc _bloc = context.read<OtpBloc>();

  String _formatSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2)}:${seconds.toString().padLeft(2, "0")}';
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(OtpInitialized(
        phoneNumber: widget.number!, duration: _bloc.state.countDown));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _reFresh() async {
    _bloc.add(OtpInitialized(
        phoneNumber: widget.number!.replaceAll(' ', ''),
        duration: _bloc.state.countDown));
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
      body: BlocConsumer<OtpBloc, OtpState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is OtpVerificationFailure) {
            setState(() {
              _error = state.errorMessage;
            });
          }
          if (state is OtpExpired) {
            setState(() {
              _isExpired = true;
            });
          }
          if (state is OtpVerificationSuccess) {
            widget.hasForgottenPassword
                ? context.router.push(const NewPasswordRoute())
                : context.router.push(const RegisterRoute());
          }
        },
        builder: (context, state) {
          if (state is OtpLoadingState) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is OtpSendFailure) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Échec du chargement. Veuillez réessayer."),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reFresh,
                      child: Text(
                        "Réessayer",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SafeArea(
            child: Form(
              key: _formField,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                height: context.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gap(30.h),
                      Text(
                        'OTP Verification',
                        style: context.textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Gap(30.h),
                      Text(
                        'Nous avons envoyé un code au numero whatsApp ${widget.number!.split(' ').join().substring(0, 3)}*****${widget.number!.split(' ').join().substring(8)}',
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Gap(100.h),
                      Text(
                        'Entrer le code OTP',
                        style: context.textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Gap(40.h),
                      PinCodeWidget(
                        error: _error,
                        textEditingController: _textEditingController,
                        onCompleted: (value) async {
                          setState(() {
                            _currentText = value;
                            print("currentx $_currentText");
                            if (_currentText!.length >= 4) {
                              _bloc.add(OtpSubmitted(
                                  otp: _currentText!,
                                  phoneNumber: widget.number!));
                            }
                          });
                        },
                      ),
                      Gap(110.h),
                      Opacity(
                        opacity: !_isExpired ? 0.5 : 1,
                        child: IgnorePointer(
                          ignoring: !_isExpired,
                          child: AppButton(
                              bgColor: AppColors.primary,
                              loading: state is OtpVerifying,
                              text: "Renvoyer le code OTP",
                              onPressed: () {
                                if (_formField.currentState!.validate()) {
                                  setState(() {
                                    _isExpired = !_isExpired;
                                    _error = null;
                                    _textEditingController.clear();
                                    context.read<OtpBloc>().add(
                                        OtpReset(phoneNumber: widget.number!));
                                    if (state is OtpVerificationSuccess) {
                                      print("Success");
                                    } else if (state
                                        is OtpVerificationFailure) {
                                      print("No Success");
                                    }
                                  });
                                }
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
                        ),
                      ),
                      Gap(20.h),
                      Visibility(
                        visible: !_isExpired,
                        child: SizedBox(
                          width: 250.w,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            "Tu peux demander un autre code OTP dans "),
                                    TextSpan(
                                        text: _formatSeconds(state.countDown),
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(color: AppColors.red))
                                  ])),
                        ),
                      ),
                      Gap(20.h)
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
