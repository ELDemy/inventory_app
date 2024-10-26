import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';
import 'package:inventory_app/features/product_management/presentation/add_new_product/add_new_product_screen.dart';

import 'widgets/products_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewProductScreen(),
                    ));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: const ProductsList(),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      elevation: 20,
      onPressed: () {},
      child: SvgPicture.asset(
        height: 35,
        "assets/icons/barcode-icon.svg",
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
