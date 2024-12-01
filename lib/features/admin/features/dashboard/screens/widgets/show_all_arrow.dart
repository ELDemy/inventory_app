import 'package:flutter/material.dart';

class ShowAllArrow extends StatelessWidget {
  const ShowAllArrow({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.flip(
              flipX: true,
              child: const Icon(Icons.arrow_back_ios),
            ),
            const SizedBox(height: 10),
            const Text("عرض الكل")
          ],
        ),
      ),
    );
  }
}
