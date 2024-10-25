import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

import 'widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      body: const ProductsList(),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.lightPrimaryColor,
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

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ProductCard(
          product: ProductModel(
            productName: "productName ${Random().nextInt(21)}",
            qty: Random().nextInt(21),
            price: 20,
            identifierSN: "12345",
          ),
        );
      },
    );
  }
}
