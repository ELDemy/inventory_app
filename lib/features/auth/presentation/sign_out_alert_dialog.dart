import 'package:flutter/material.dart';
import 'package:inventory_app/features/auth/presentation/signin.dart';

class SignOutAlertDialog extends StatelessWidget {
  const SignOutAlertDialog({super.key});

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Add a small delay for better UX
      await Future.delayed(const Duration(milliseconds: 500));

      // Pop both dialogs (loading and alert)
      if (context.mounted) {
        Navigator.of(context).pop(); // Pop loading
        Navigator.of(context).pop(); // Pop alert dialog

        // Navigate to sign in with fade transition
        await Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: SignInScreen(),
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء تسجيل الخروج'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      // Prevent dismissing the dialog by back button
      canPop: false,
      child: AlertDialog(
        title: Text(
          'تم حذف حسابك',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'تم حذف حسابك من النظام. سيتم تسجيل خروجك الآن.',
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => _handleSignOut(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              backgroundColor: theme.colorScheme.error.withOpacity(0.1),
            ),
            child: const Text(
              'حسناً',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        backgroundColor: theme.colorScheme.surface,
        elevation: 4,
      ),
    );
  }
}
