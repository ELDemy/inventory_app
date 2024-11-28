import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/my_barcode_icon.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/widgets/custom_card.dart';

import 'card_detail_row.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard(
      {super.key, required this.productModel, this.isOrder = false});

  final ProductModel productModel;
  final bool isOrder;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: productModel.productName ?? "###",
      iconData: Icons.inventory_2_outlined,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CardDetailRow(
                  label: "",
                  content: "${productModel.identifierSN ?? "###"} ",
                  iconWidget: const MyBarcodeIcon(height: 18),
                ),
                CardDetailRow(
                  label: "Category :",
                  content: "${productModel.category ?? "###"} ",
                  iconData: Icons.category_outlined,
                ),
                // if (productModel.power != '')
                //   CardDetailRow(
                //     label: "Power :",
                //     content: "${productModel.power ?? "###"} ",
                //     iconData: Icons.bolt,
                //   ),
                // if (productModel.input != '')
                //   CardDetailRow(
                //     label: "Input :",
                //     content: "${productModel.input ?? "###"} ",
                //     iconData: Icons.south_west_rounded,
                //   ),
                // if (productModel.output != '')
                //   CardDetailRow(
                //     label: "Output :",
                //     content: "${productModel.output ?? "###"} ",
                //     iconData: Icons.north_east_rounded,
                //   ),
                if (!isOrder)
                  CardDetailRow(
                    label: "السعر :",
                    content: "${productModel.price}",
                    iconData: Icons.attach_money_rounded,
                  ),
                if (!isOrder)
                  CardDetailRow(
                    label: "الكمية المتاحة :",
                    content: "${productModel.qty}",
                    iconData: Icons.inventory_rounded,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
