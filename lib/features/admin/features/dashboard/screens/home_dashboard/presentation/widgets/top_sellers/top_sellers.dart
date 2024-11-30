import 'package:flutter/material.dart';

import '../helpers/report_widget.dart';
import 'top_sellers_data.dart';

class TopSellers extends StatelessWidget {
  const TopSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReportWidget(
      height: 120,
      title: "اداء الموظفين",
      showAllOnTap: () {},
      childBuilder: (index) => TopSellersData(index: index),
    );
  }
}
