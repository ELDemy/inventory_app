import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/user_management/data/user_management_cubit/user_management_cubit.dart';
import 'package:inventory_app/features/user_management/presentation/widgets/user_management_body.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserManagementCubit(),
      child: const UserManagementBody(),
    );
  }
}
