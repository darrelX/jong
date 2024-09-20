import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/offline_status_widget.dart';
import 'package:jong/shared/widget/online_status_widget.dart';

class AppSnackBar {
  static Flushbar? _flushbar;

  static Future showError({
    required String message,
    required BuildContext context,
    duration = const Duration(seconds: 3),
  }) async {
    if (_flushbar != null && _flushbar!.isShowing()) {
      await _flushbar!.dismiss();
    }
    _flushbar = Flushbar(
      message:
          message.length > 750 ? "${message.substring(0, 750)}..." : message,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: AppColors.red,
      duration: duration,
    );
    if (!context.mounted) return;
    return _flushbar!.show(context);
  }

  static Future showSuccess({
    required String message,
    Widget? child,
    required BuildContext context,
    Function(Flushbar<dynamic>)? onTap,
    duration = const Duration(seconds: 3),
  }) async {
    if (_flushbar != null && _flushbar!.isShowing()) {
      await _flushbar!.dismiss();
    }
    _flushbar = Flushbar(
      onTap: onTap,
      messageText: Row(
        children: [
          Expanded(
            child: Text(
              message.length > 1000
                  ? "${message.substring(0, 1000)}..."
                  : message,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      // icon: Image.asset("assets/images/app_icon.png"),
      backgroundColor: AppColors.green,
      duration: duration,
    );
    if (!context.mounted) return;
    return _flushbar!.show(context);
  }

  static Future showCheckConnectivity(
      {required BuildContext context, required bool isConnected}) async {
    if (_flushbar != null && _flushbar!.isShowing()) {
      await _flushbar!.dismiss();
    }
    _flushbar = Flushbar(
      // onTap: onTap,
      messageText: Row(
        children: [
          Expanded(
            child: !isConnected
                ? const OfflineStatusWidget()
                : const OnlineStatusWidget(),
          ),
        ],
      ),
      // margin: const EdgeInsets.only(top: 500),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      // icon: Image.asset("assets/images/app_icon.png"),
      backgroundColor: AppColors.transparent,
      duration: const Duration(seconds: 2),
    );
    if (!context.mounted) return;

    return _flushbar!.show(context);
  }
}
