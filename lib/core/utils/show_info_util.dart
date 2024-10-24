import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowInfoUtil {
  static showToast(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static MaterialBanner loadingBanner() {
    return MaterialBanner(
      content: const SizedBox(
          height: 42, width: 24, child: CircularProgressIndicator()),
      dividerColor: Colors.transparent,
      actions: [SizedBox()],
    );
  }

  static void hideCurrentMaterialBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }
}
