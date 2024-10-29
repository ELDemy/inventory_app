import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/auth/presentation/signin.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';
import 'package:inventory_app/features/user_management/presentation/user_management_screen.dart';
import 'package:inventory_app/super_admin.dart';

import 'widgets/anim_search.dart';
import 'widgets/my_expandable_fab.dart';
import 'widgets/products_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text("الصفحة الرئيسية"),
          ),
          actions: [
            const CustomAnimatedSearchBar(),
            _usersIcons(context) ?? const SizedBox(),
            const SizedBox(width: 5),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const MyExpandableFAB(),
        body: const ProductsList(),
      ),
    );
  }

  InkWell? _usersIcons(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.email == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    } else if (Injector.userModel?.role == "المدير" ||
        SuperAdmin.isSuperAdmin()) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UserManagementScreen()),
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
            Icons.person,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }
    return null;
  }
}
