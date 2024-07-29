import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:jong/shared/widget/app_input.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Center(
            child: Image.asset(
              'assets/images/play.png',
            ),
          ),
          const Gap(30),
          Text(
            " Welcome to\njong game",
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
          const Gap(20),
          Text(
            "start wining right now",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * .1,
            ),
            child: AppButton(
              bgColor: AppColors.primary,
              height: 55.h,
              text: 'Get started',
              onPressed: () {
                AppDialog.showDialog(
                  context: context,
                  width: 300,
                  height: 270,
                  child: const PlaceABetWidget(),
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class PlaceABetWidget extends StatefulWidget {
  const PlaceABetWidget({
    super.key,
  });

  @override
  State<PlaceABetWidget> createState() => _PlaceABetWidgetState();
}

class _PlaceABetWidgetState extends State<PlaceABetWidget> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Place a bet",
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 26,
              ),
            ),
            AppInput(
              controller: _amountController,
              label: 'Amount',
              labelColors: AppColors.primary,
              hint: "Min: 300",
              keyboardType: TextInputType.number,
              maxLength: 6,
              showHelper: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(300,
                    errorText: "La valeur entree est inferieur a 300"),
                    
              ],
            ),
            
            AppButton(
              bgColor: AppColors.primary,
              text: "Start the game",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.router.popAndPush(
                    GameRoute(
                      bet: double.parse(_amountController.text),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
