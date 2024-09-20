import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:jong/shared/widget/app_input.dart';
import 'package:jong/shared/widget/app_snackbar.dart';
import 'package:jong/topup/cubit/transaction_cubit.dart';
import 'package:jong/topup/widgets/validation_payement_widget.dart';

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
  final _bloc = TransactionCubit();
  bool _isLoading = false;
  Timer? _timer;
  Timer? _timeoutTimer;

  PhoneNumber? _number;
  String? pm;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _timer?.cancel();
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _manageTransactionState(TransactionPending state) {
    print("statuts statuts");
    // _timeoutTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Vérification du statut de la transaction
      _bloc.checkStatut();
      if (state is TransactionSuccess || state is TransactionFailure) {
        setState(() {
          _isLoading = false;
          print(_isLoading);
        });

        // Gestion des cas de succès ou d'échec
        if (state is TransactionSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              AppDialog.showDialog(
                  context: context, child: const ValidationPayementWidget()));
        } else if (state is TransactionFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              AppSnackBar.showError(
                  message: "Transaction échouée", context: context));
        }
      }
      // Annulation des timers
      if (timer.tick == 4) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            AppSnackBar.showError(
                message: "Transaction échouée", context: context));
        setState(() {
          _isLoading = false;
        });
        timer.cancel();
      }
    });
  }

  void _handleTransactionState(TransactionState state) {
    if (state is TransactionPending) {
      setState(() {
        _isLoading = true;
      });
      _manageTransactionState(state);
    }
    if (state is TransactionFailure) {
      WidgetsBinding.instance.addPostFrameCallback((_) => AppSnackBar.showError(
          message: "Transaction échouée", context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popup account"),
      ),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          _handleTransactionState(state);
        },
        bloc: _bloc,
        builder: (context, state) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: _isLoading,
                child: Padding(
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
                                "Enter votre numero de telephone",
                                style:
                                    context.textTheme.headlineMedium?.copyWith(
                                  fontSize: 28.sp,
                                ),
                              ),
                              Gap(30.h),
                              Text(
                                "Numero de telephone",
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                              const Gap(6),
                              InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber value) {
                                  setState(() {
                                    _number = value;
                                  });
                                },
                                hintText: '',
                                initialValue: PhoneNumber(isoCode: 'CM'),
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                  useBottomSheetSafeArea: true,
                                  setSelectorButtonAsPrefixIcon: true,
                                  leadingPadding: 10,
                                ),
                                inputDecoration: InputDecoration(
                                  contentPadding: context.theme
                                      .inputDecorationTheme.contentPadding,
                                ),
                                ignoreBlank: false,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                textFieldController: _phoneController,
                                formatInput: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
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
                                autoValidate:
                                    AutovalidateMode.onUserInteraction,
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
                                value: 'MTN_MOMO',
                                groupValue: pm,
                                onChanged: (value) {
                                  // if (value == null) return;
                                  setState(() {
                                    pm = value!;
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mobile Money",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
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
                                value: 'ORANGE_MONEY',
                                groupValue: pm,
                                onChanged: (value) {
                                  // if (value == null) return;
                                  setState(() {
                                    pm = value!;
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Orange Money",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
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
                        Gap(10.h),
                        AppButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (pm == null) {
                                AppSnackBar.showError(
                                  message: "Please select a payment method.",
                                  context: context,
                                );
                                return;
                              }
                              await _bloc.deposit(
                                  pm!,
                                  int.parse(_amountController.value.text),
                                  _number!.phoneNumber!.substring(4));
                              // if (!context.mounted) return;

                              // context.router.pushAndPopUntil(const HomeRoute(),
                              //     predicate: (route) => false);
                            }
                          },
                          bgColor: AppColors.primary,
                          text: 'Top up my account',
                        ),
                        const Gap(8),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Assombrir l'écran
                    child: const Center(
                      child:
                          CircularProgressIndicator(), // Indicateur de chargement
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
