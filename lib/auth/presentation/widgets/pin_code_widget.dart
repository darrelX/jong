import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeWidget extends StatefulWidget {
  final String? error;
  final TextEditingController textEditingController;
  final void Function(String) onCompleted;
  const PinCodeWidget({
    super.key,
    required this.error,
    required this.textEditingController,
    required this.onCompleted,
  });

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      // height: 0.h,
      child: Column(
        children: [
          PinCodeTextField(
            appContext: context,
            length: 6,
            autoDisposeControllers: false,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 80.h,
              fieldWidth: 40.w,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              activeColor: const Color(0xFFCD6E24),
              inactiveColor: const Color(0xFFCD6E24),
              selectedColor: const Color(0xFFCD6E24),
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.textEditingController,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onCompleted: (v) {
              setState(() {
                print("Completed");
              });
            },

            // inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly,
            // ],
            onChanged: widget.onCompleted,
            beforeTextPaste: (text) {
              return true;
            },
          ),
          widget.error == null
              ? const SizedBox()
              : Row(
                  children: [
                    Text(widget.error!,
                        style: context.textTheme.bodyLarge!.copyWith(
                            color: AppColors.red, fontWeight: FontWeight.w900)
                        // textAlign: TextAlign.left,
                        ),
                    const Spacer(),
                  ],
                ),
        ],
      ),
    );
  }
}
