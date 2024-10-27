import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'custom_card.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    MakeOrderCubit orderCubit = BlocProvider.of<MakeOrderCubit>(context);
    return CustomCard(
      title: orderCubit.productModel.productName ?? "###",
      iconData: Icons.inventory_2_outlined,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProductDetailRow(
                  label: "",
                  content: "${orderCubit.productModel.identifierSN ?? "###"} ",
                  iconWidget: barcodeIcon(),
                ),
                ProductDetailRow(
                  label: "Power :",
                  content: "${orderCubit.productModel.power ?? "###"} ",
                  iconData: Icons.bolt,
                ),
                ProductDetailRow(
                  label: "Input :",
                  content: "${orderCubit.productModel.input ?? "###"} ",
                  iconData: Icons.south_west_rounded,
                ),
                ProductDetailRow(
                  label: "Output :",
                  content: "${orderCubit.productModel.output ?? "###"} ",
                  iconData: Icons.north_east,
                ),
                ProductDetailRow(
                  label: "السعر :",
                  content: "${orderCubit.productModel.price}",
                  iconData: Icons.attach_money_rounded,
                ),
                ProductDetailRow(
                  label: "الكمية المتاحة :",
                  content: "${orderCubit.productModel.qty}",
                  iconData: Icons.inventory_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SvgPicture barcodeIcon() {
    return SvgPicture.asset(
      height: 18,
      "assets/icons/barcode-icon.svg",
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
    );
  }
}

class ProductDetailRow extends StatelessWidget {
  const ProductDetailRow({
    super.key,
    required this.label,
    required this.content,
    this.iconWidget,
    this.iconData,
  });

  final String label;
  final String content;
  final Widget? iconWidget;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget ?? Icon(iconData, size: 20),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                    color: AppColors.primaryColor, fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
