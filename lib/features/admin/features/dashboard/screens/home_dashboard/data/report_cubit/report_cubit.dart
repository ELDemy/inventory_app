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
  ReportMainStats statistics = ReportMainStats();
  List<ProductStats> productStats = [];
  List<EmployeeStats> employeeStats = [];

  Future<void> getAllOrders(DateTime startDate, DateTime endDate) async {
    try {
      emit(ReportLoading());
      allOrders = await orderRepository.getOrdersByDateRange(
          startDate: startDate, endDate: endDate);

      _calculateAllStats();

      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure(e.toString()));
    }
  }

  void _calculateAllStats() {
    // Create containers
    final mainStatsContainer = _MainStatsContainer();
    final productStatsContainer = _ProductStatsContainer();
    final employeeStatsContainer = _EmployeeStatsContainer();

    // Single pass through all orders
    for (OrderModel order in allOrders) {
      mainStatsContainer.processOrder(order);
      productStatsContainer.processOrder(order);
      employeeStatsContainer.processOrder(order);
    }

    // Set final statistics
    statistics = mainStatsContainer.toReportMainStats();
    productStats = productStatsContainer.toSortedProductStats();
    employeeStats = employeeStatsContainer.toSortedEmployeeStats();
  }
}

class _MainStatsContainer {
  final Set<String> _totalProducts = {};
  final Set<String> _uniqueCustomers = {};
  int _totalOrders = 0;
  double _totalRevenue = 0;
  int _totalUnits = 0;

  void processOrder(OrderModel order) {
    _totalOrders++;
    _totalProducts.add(order.product.identifierSN ?? "");
    _uniqueCustomers.add(order.clientName ?? "");
    _totalRevenue += order.price;
    _totalUnits += order.quantity;
  }

  ReportMainStats toReportMainStats() {
    return ReportMainStats(
      totalOrders: _totalOrders,
      totalProducts: _totalProducts.length,
      totalRevenue: _totalRevenue,
      totalUnits: _totalUnits,
      uniqueCustomers: _uniqueCustomers.length,
    );
  }
}

class _ProductStatsContainer {
  final Map<String, ProductStats> _productStatsMap = {};

  void processOrder(OrderModel order) {
    String productIdentifier = order.product.identifierSN ?? "غير معرف";

    if (!_productStatsMap.containsKey(productIdentifier)) {
      _productStatsMap[productIdentifier] = ProductStats(
        productModel: order.product,
        totalUnits: order.quantity,
        totalRevenue: order.price,
      );
    } else {
      _productStatsMap[productIdentifier]!.totalUnits += order.quantity;
      _productStatsMap[productIdentifier]!.totalRevenue += order.price;
    }
  }

  List<ProductStats> toSortedProductStats() {
    return _productStatsMap.values.toList()
      ..sort((a, b) => b.totalUnits.compareTo(a.totalUnits));
  }
}

class _EmployeeStatsContainer {
  final Map<String, EmployeeStats> _employeeStatsMap = {};

  void processOrder(OrderModel order) {
    String employeeName = order.employee ?? "غير معرف";

    if (!_employeeStatsMap.containsKey(employeeName)) {
      _employeeStatsMap[employeeName] = EmployeeStats(
        employeeName: employeeName,
        totalUnits: order.quantity,
        totalRevenue: order.price,
      );
    } else {
      _employeeStatsMap[employeeName]!.totalUnits += order.quantity;
      _employeeStatsMap[employeeName]!.totalRevenue += order.price;
    }
  }

  List<EmployeeStats> toSortedEmployeeStats() {
    return _employeeStatsMap.values.toList()
      ..sort((a, b) => b.totalUnits.compareTo(a.totalUnits));
  }
}
