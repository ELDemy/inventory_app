import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:inventory_app/features/home/presentation/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ShowInfoUtil.showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              ShowInfoUtil.showSnackBar(context, 'تم تسجيل الدخول بنجاح!');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/logo.png", height: 200),
                        const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'البريد الالكتروني',
                          isRequired: true,
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'كلمة السر',
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().signIn(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          context: context);
                                    }
                                  },
                            child: state is AuthLoading
                                ? const CircularProgressIndicator()
                                : const Text('تسجيل الدخول'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
