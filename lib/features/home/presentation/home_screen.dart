import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';

import 'widgets/anim_search.dart';
import 'widgets/my_expandable_fab.dart';
import 'widgets/products_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الصفحة الرئيسية"),
          centerTitle: true,
          actions: const [
            CustomAnimatedSearchBar(),
            SizedBox(width: 16),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const MyExpandableFAB(),
        body: const ProductsList(),
      ),
    );
  }
}
