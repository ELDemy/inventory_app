import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:meta/meta.dart';

import '../dashboard_repo/dashboard_repo.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final OrderRepository orderRepository = FirebaseOrderRepository();

  ReportCubit() : super(ReportInitial());

  List<OrderModel> allOrders = [];
  ReportStatistics statistics = ReportStatistics();
  List<ProductStats> productStats = [];

  Future<void> getAllOrders(DateTime startDate, DateTime endDate) async {
    try {
      emit(ReportLoading());
      allOrders = await orderRepository.getOrdersByDateRange(
          startDate: startDate, endDate: endDate);

      calculateMainStatistics();

      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure(e.toString()));
    }
  }

  void calculateMainStatistics() {
    int totalOrders = allOrders.length;
    Set<String> totalProducts =
        allOrders.map((order) => order.product.identifierSN ?? "").toSet();
    Set<String> uniqueCustomers =
        allOrders.map((order) => order.clientName ?? "").toSet();

    double totalRevenue =
        allOrders.fold<double>(0, (sum, order) => sum + (order.price));
    int totalUnits =
        allOrders.fold<int>(0, (sum, order) => sum + order.quantity);

    statistics = ReportStatistics(
      totalOrders: totalOrders,
      totalProducts: totalProducts.length,
      totalRevenue: totalRevenue,
      totalUnits: totalUnits,
      uniqueCustomers: uniqueCustomers.length,
    );
  }

  void calculateProductStatistics() {
    Map<String, ProductStats> productStatsMap = {};

    for (OrderModel order in allOrders) {
      String productIdentifier = order.product.identifierSN ?? "غير معرف";

      if (!productStatsMap.containsKey(productIdentifier)) {
        productStatsMap[productIdentifier] = ProductStats(
          productModel: order.product,
          totalUnits: order.quantity,
          totalRevenue: order.price,
        );
      } else {
        productStatsMap[productIdentifier]!.totalUnits += order.quantity;
        productStatsMap[productIdentifier]!.totalRevenue += order.price;
      }
    }

    // Convert map to list and sort by total revenue in descending order
    productStats = productStatsMap.values.toList()
      ..sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));
  }
}

class ProductStats {
  final ProductModel productModel;
  int totalUnits;
  num totalRevenue;

  ProductStats({
    required this.productModel,
    required this.totalUnits,
    required this.totalRevenue,
  });
}
