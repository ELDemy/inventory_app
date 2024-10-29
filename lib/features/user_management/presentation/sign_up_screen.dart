import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/user_management/data/user_management_cubit/user_management_cubit.dart';

// sign_up_screen.dart
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserManagementCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('اضافة مستخدم جديد')),
        body: BlocConsumer<UserManagementCubit, UserManagementState>(
          listener: (context, state) {
            if (state is UserSignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is UserSignUpSuccess) {
              ShowInfoUtil.showSnackBar(context, 'تم التسجيل بنجاح');
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: 'اسم المسخدم',
                      isRequired: true,
                    ),
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
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state is UserSignUpLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<UserManagementCubit>().signUp(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                      );
                                }
                              },
                        child: state is UserSignUpLoading
                            ? const CircularProgressIndicator()
                            : const Text('تسجيل المستخدم'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
