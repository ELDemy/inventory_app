import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/user_management/data/user_management_cubit/user_management_cubit.dart';
import 'package:inventory_app/features/user_management/data/user_model.dart';
import 'package:inventory_app/features/user_management/presentation/sign_up_screen.dart';

class UserManagementBody extends StatelessWidget {
  const UserManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen())),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserManagementLoading) {
            return const MyCircularLoading();
          } else if (state is UserManagementFailure) {
            return _failureScreen(state, context);
          }
          final List<UserModel> users =
              context.read<UserManagementCubit>().users;

          if (users.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمين حالياً'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserModel user = users[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.lightRedColor,
                    ),
                    onPressed: () => _showDeleteConfirmation(context, user),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل تريد حذف المستخدم ${user.name}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<UserManagementCubit>().deleteUser(user.email);
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lightRedColor,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  FailureScreen _failureScreen(
      UserManagementFailure state, BuildContext context) {
    return FailureScreen(
      errMsg: state.errMsg,
      onTap: () {
        context.read<UserManagementCubit>().getUsers();
      },
    );
  }
}
