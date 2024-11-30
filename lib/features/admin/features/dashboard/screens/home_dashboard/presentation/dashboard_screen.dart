import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/presentation/widgets/order_history/order_history.dart';

import 'widgets/top_sellers/top_sellers.dart';
import 'widgets/top_sold_products/top_sold_products.dart';
import 'widgets/total_revenue_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit()
        ..getAllOrders(
          DateTime.now().subtract(const Duration(days: 30)),
          DateTime.now(),
        ),
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('تقارير العمل'),
            ),
            body: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReportFailure) {
                  return FailureScreen(
                    errMsg: state.errMsg,
                    onTap: () => context.read<ReportCubit>().getAllOrders(
                          DateTime.now().subtract(const Duration(days: 10)),
                          DateTime.now(),
                        ),
                  );
                } else if (state is ReportSuccess) {
                  return const DashboardContent();
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'اليومي',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        DropdownButton<String>(
          value: 'اليومي',
          items: ['اليومي', 'أسبوعي', 'شهري']
              .map((period) => DropdownMenuItem(
                    value: period,
                    child: Text(period),
                  ))
              .toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildKeyMetrics(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إجمالي الإيرادات',
            // style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            '2,120,160 ر.س. +20%',
            // style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          _buildMetricRow(context, 'الوحدات المباعة', '20 +20%'),
          const SizedBox(height: 8),
          _buildMetricRow(context, 'عملاء جدد', '20 +20%'),
          const SizedBox(height: 8),
          _buildMetricRow(context, 'متوسط إيرادات الطلب', '20 +20%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildTopProducts(BuildContext context) {
    return _buildSection(
      context,
      'أفضل المنتجات',
      Column(
        children: [
          _buildProductRow(context, 'VDS40-2S1.5', '715 items sold +40%',
              '\$3500 Revenue +20%'),
          const SizedBox(height: 8),
          _buildProductRow(context, 'V9-H-2TO.756-14', '43 items sold +20%',
              '\$212 Revenue +20%'),
        ],
      ),
    );
  }

  Widget _buildProductRow(
      BuildContext context, String name, String sales, String revenue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: Theme.of(context).textTheme.bodyMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(sales, style: Theme.of(context).textTheme.bodyMedium),
            Text(revenue, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildSellerPerformance(BuildContext context) {
    return _buildSection(
      context,
      'أداء البائع',
      Column(
        children: [
          _buildSellerRow(
              context, 'Mohamed', '715 items sold +40%', '\$3500 Revenue +20%'),
          const SizedBox(height: 8),
          _buildSellerRow(
              context, 'Mahmoud', '43 items sold +20%', '\$212 Revenue +20%'),
        ],
      ),
    );
  }

  Widget _buildSellerRow(
      BuildContext context, String name, String sales, String revenue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: Theme.of(context).textTheme.bodyMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(sales, style: Theme.of(context).textTheme.bodyMedium),
            Text(revenue, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderHistory(BuildContext context) {
    return _buildSection(
      context,
      'تاريخ الطلب',
      Column(
        children: [
          _buildOrderRow(context, 'VDS40-2S1.5', 'العميل: John Doe',
              'البائع: Mohamed', '\$950'),
          const SizedBox(height: 8),
          _buildOrderRow(
              context, 'VDS40-2', 'العميل: Customer', 'البائع: Mohi', '\$1000'),
        ],
      ),
    );
  }

  Widget _buildOrderRow(
    BuildContext context,
    String orderID,
    String customer,
    String seller,
    String amount,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderID, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(customer, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(seller, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Text(amount, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalRevenueCard(),
            SizedBox(height: 14),
            TopSoldProducts(),
            TopSellers(),
            OrderHistory(),
          ],
        ),
      ),
    );
  }
}
