// Example usage in splash screen:
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:inventory_app/features/auth/presentation/signin.dart';
import 'package:inventory_app/features/home/presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      bool isLoggedIn = await BlocProvider.of<AuthCubit>(context)
          .checkInitialAuthState(context);

      if (isLoggedIn) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    } catch (e) {
      log('Error checking login status: $e');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MyCircularLoading());
  }
}
