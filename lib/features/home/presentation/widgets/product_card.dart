import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 5,
      color: AppColors.primaryBackgroundColor,
      shadowColor: AppColors.primaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 8),
        child: Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Transform.flip(
                  flipX: true,
                  child: SvgPicture.asset(
                    "assets/icons/arrow-right.svg",
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName ?? "",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text("#${product.identifierSN}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الكمية: ${product.qty}"),
                      const SizedBox(width: 30),
                      Text("السعر : ${product.price}"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get _cardColor {
    return AppColors.primaryBackgroundColor;
    switch (product.qty) {
      case >= 15:
        return AppColors.primaryBackgroundColor;
      case >= 10:
        return AppColors.lightApprovedColor;
      case < 10:
        return AppColors.lightRejectedColor;
    }
    return AppColors.primaryBackgroundColor;
  }
  //
  // Text _requestDate(RequestModel2 request) {
  //   DateFormat format = DateFormat('M/dd');
  //   if (request.date.year != DateTime.now().year) {
  //     format = DateFormat('yyyy/MM/dd');
  //   }
  //
  //   return Text(
  //     format.format(request.date),
  //     style: TextStyle(
  //       fontSize: 14,
  //       color: AppColors.lightBlack,
  //     ),
  //   );
  // }
  //
  // Text _rStatus(RequestModel2 request) {
  //   return Text(
  //     request.status,
  //     style: const TextStyle(
  //
  //         ///todo
  //         // color: request.statusDetails.color,
  //         ),
  //   );
  // }
}
