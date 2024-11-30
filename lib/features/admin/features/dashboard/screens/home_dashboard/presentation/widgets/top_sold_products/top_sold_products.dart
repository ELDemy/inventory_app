import 'package:flutter/material.dart';

import '../helpers/report_widget.dart';
import 'top_sold_product_card_data.dart';

class TopSoldProducts extends StatelessWidget {
  const TopSoldProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReportWidget(
      title: "افضل المنتجات",
      showAllOnTap: () {},
      childBuilder: (index) => TopSoldProductCardData(index: index),
    );
  }
}
