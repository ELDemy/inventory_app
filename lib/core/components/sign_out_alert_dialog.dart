import 'package:flutter/material.dart';
import 'package:inventory_app/features/auth/presentation/signin.dart';

class SignOutAlertDialog extends StatelessWidget {
  const SignOutAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تم حذف حسابك'),
      content: const Text('تم حذف حسابك من النظام. سيتم تسجيل خروجك الآن.'),
      actions: [
        TextButton(
          child: const Text('حسناً'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
