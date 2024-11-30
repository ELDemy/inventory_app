import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          CategoryWidget(
            null,
            () {
              BlocProvider.of<HomeCubit>(context).changeCategory(null);
              setState(() {});
            },
          ),
          ...Injector.productsCategories.map(
            (category) => CategoryWidget(
              category,
              () {
                BlocProvider.of<HomeCubit>(context).changeCategory(category);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(this.category, this.onTap, {super.key});
  final String? category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: AppColors.primaryColor,
          backgroundColor: _backgroundColor(context),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.primaryColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(category ?? "All"),
      ),
    );
  }

  Color _backgroundColor(context) {
    return category == BlocProvider.of<HomeCubit>(context).selectedCategory
        ? AppColors.primaryColor
        : AppColors.primaryBackgroundColor;
  }
}
