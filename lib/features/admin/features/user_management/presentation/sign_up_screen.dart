import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_dropdown_button_form_field.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/utils/app_icons.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/admin/features/user_management/data/user_management_cubit/user_management_cubit.dart';

// sign_up_screen.dart
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _userTypeController.text = 'مستخدم عادي';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userTypeController.dispose();
    super.dispose();
  }

  ValueNotifier<String> selectedRole = ValueNotifier<String>("مستخدم عادي");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اضافة مستخدم جديد')),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is UserSignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errMsg), backgroundColor: Colors.red),
            );
          } else if (state is UserSignUpSuccess) {
            ShowInfoUtil.showSnackBar(context, 'تم التسجيل بنجاح');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    AppIcons().appLogo(height: 200),
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: 'اسم المسخدم',
                      isRequired: true,
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: selectedRole,
                      builder: (context, category, child) {
                        return CategorySelectionField(
                          height: 250,
                          categories: ['مستخدم عادي', 'مدير'],
                          selectedCategory: category,
                          onCategorySelected: (role) {
                            selectedRole.value = role;
                          },
                          isEditable: false,
                          onNewCategoryAdded: (newCategory) {},
                        );
                      },
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
                                        role: selectedRole.value,
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
            ),
          );
        },
      ),
    );
  }
}
