import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_icons.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/features/admin/features/user_management/presentation/user_management_screen.dart';

import '../features/dashboard/screens/home_dashboard/dashboard_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl, // Arabic right-to-left direction
      child: Scaffold(
        appBar: AppBar(title: const Text('الإدارة')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                AppIcons().appLogo(),
                _buildNavigationCard(
                  context,
                  icon: Icons.people,
                  title: 'إدارة المستخدمين',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.2,
                  onTap: () => _navigateToUserManagement(context),
                ),
                const SizedBox(height: 20),
                _buildNavigationCard(
                  context,
                  icon: Icons.dashboard,
                  title: 'التقارير',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.2,
                  onTap: () => _navigateToDashboard(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: AppColors.labelColor,
              ),
              const SizedBox(height: 10),
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 18, // Adjust for Arabic text
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUserManagement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserManagementScreen(),
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }
}
