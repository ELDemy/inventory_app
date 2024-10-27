import 'package:flutter/material.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen(
      {super.key, required this.errMsg, this.bottomText, this.onTap});

  final String errMsg;
  final VoidCallback? onTap;
  final String? bottomText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errMsg,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (onTap != null)
            ElevatedButton(
              onPressed: onTap,
              child: const Text("اعادة المحاولة"),
            ),
          Text(bottomText ?? ""),
        ],
      ),
    );
  }
}
