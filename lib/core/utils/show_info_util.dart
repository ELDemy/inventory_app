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

  static void showMaterialBanner(
    BuildContext context, {
    required String msg,
    List<Widget> actions = const [SizedBox()],
    bool isDismissible = false,
  }) {
    hideCurrentMaterialBanner(context);
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(msg),
        backgroundColor: const Color(0xDFD32F2F),
        actions: isDismissible
            ? [
                TextButton(
                  onPressed: () {
                    hideCurrentMaterialBanner(context);
                  },
                  child: const Text('اخفاء'),
                ),
              ]
            : actions,
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(strokeCap: StrokeCap.round),
          ),
        ),
      ),
    );
    // ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(
    //   content: Center(
    //     child: SizedBox(
    //       height: 20,
    //       width: 20,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 2,
    //         strokeCap: StrokeCap.round,
    //       ),
    //     ),
    //   ),
    //   dividerColor: Colors.transparent,
    //   backgroundColor: Colors.transparent,
    //   // padding: EdgeInsets.symmetric(vertical: 8),
    //   actions: [SizedBox()],
    // ));
  }

  static void hideCurrentMaterialBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  static void showSnackBar(BuildContext context, String content) {
    hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  static void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static PreferredSize loadingIndicator(bool isLoading) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(2),
      child: isLoading
          ? const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const SizedBox.shrink(),
    );
  }
}
