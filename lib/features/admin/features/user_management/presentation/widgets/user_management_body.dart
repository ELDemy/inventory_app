import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/models/user_model.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/features/admin/features/user_management/data/user_management_cubit/user_management_cubit.dart';
import 'package:inventory_app/features/admin/features/user_management/presentation/sign_up_screen.dart';

class UserManagementBody extends StatelessWidget {
  const UserManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
        actions: [
          _addIcon(context),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserManagementLoading) {
            return const MyCircularLoading();
          } else if (state is UserManagementFailure) {
            return _failureScreen(state, context);
          }
          List<UserModel> users = context.watch<UserManagementCubit>().users;

          if (users.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمين حالياً'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserModel user = users[index];
              return userCard(user, context);
            },
          );
        },
      ),
    );
  }

  Card userCard(UserModel user, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              user.role == 'مدير' ? AppColors.lightGreenColor : null,
          child: const Icon(Icons.person),
        ),
        title: Text(user.name),
        subtitle: Text("${user.email}\n${user.password}"),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        trailing: InkWell(
          onTap: () => _showDeleteConfirmation(context, user),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.lightRedColor,
          ),
        ),
      ),
    );
  }

  InkWell _addIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<UserManagementCubit>(),
              child: const SignUpScreen(),
            ),
          ),
        );
      },
      child: Container(
        height: 35,
        width: 48,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.appBarIconsColor,
        ),
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
