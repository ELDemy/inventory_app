import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/add_new_product/add_new_product_screen.dart';

import 'widgets/my_expandable_fab.dart';
import 'widgets/products_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewProductScreen()),
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const MyExpandableFAB(),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: const ProductsList(),
      ),
    );
  }
}
