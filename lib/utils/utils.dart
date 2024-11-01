import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void fieldFocusChange(BuildContext? context,
      FocusNode? currentFocusNode, FocusNode? nextFocusNode) {
    currentFocusNode!.unfocus();
    FocusScope.of(context!).requestFocus(nextFocusNode!);
  }

  static snackBarMessage({
    required BuildContext context,
    required String message,
    Duration? duration,
    bool? forError = false,
    bool? showCloseIcon,
    Color? closeIconColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style:
            Theme.of(context).textTheme.titleSmall!.apply(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(20),
      backgroundColor: forError == false ? Colors.green : Colors.red,
      duration: duration ?? const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      elevation: 0.50,
      showCloseIcon: showCloseIcon ?? false,
      closeIconColor: closeIconColor ?? Colors.white,
    ));
  }

  static hideKeyboard() {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } catch (e) {
      return;
    }
  }

  static Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
