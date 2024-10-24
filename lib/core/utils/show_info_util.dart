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
      content: const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
      dividerColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      // padding: EdgeInsets.symmetric(vertical: 8),
      actions: [SizedBox()],
    );
  }

  static void hideCurrentMaterialBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  static void hideCurrentSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
