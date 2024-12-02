part of 'dashboard_cubit.dart';

class _MainStatsContainer {
  final Set<String> _totalProducts = {};
  final Set<String> _uniqueclients = {};
  int _totalOrders = 0;
  double _totalRevenue = 0;
  int _totalUnits = 0;

  void processOrder(OrderModel order) {
    _totalOrders++;
    _totalProducts.add(order.product.identifierSN ?? "");
    _uniqueclients.add(order.clientName ?? "");
    _totalRevenue += order.price;
    _totalUnits += order.quantity;
  }

  ReportMainStats toReportMainStats() {
    return ReportMainStats(
      totalOrders: _totalOrders,
      totalProducts: _totalProducts.length,
      totalRevenue: _totalRevenue,
      totalUnits: _totalUnits,
      uniqueCustomers: _uniqueclients.length,
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
        orders: [order],
        uniqueClients: {order.clientName ?? ""},
      );
    } else {
      _productStatsMap[productIdentifier]!.orders.add(order);
      _productStatsMap[productIdentifier]!.totalUnits += order.quantity;
      _productStatsMap[productIdentifier]!.totalRevenue += order.price;
      _productStatsMap[productIdentifier]!
          .uniqueClients
          .add(order.clientName ?? "");
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
        uniqueClients: {order.clientName ?? ""},
        uniqueProducts: {order.product},
        orders: [order],
      );
    } else {
      _employeeStatsMap[employeeName]!.totalUnits += order.quantity;
      _employeeStatsMap[employeeName]!.totalRevenue += order.price;
      _employeeStatsMap[employeeName]!
          .uniqueClients
          .add(order.clientName ?? "");
      _employeeStatsMap[employeeName]!.uniqueProducts.add(order.product);
      _employeeStatsMap[employeeName]!.orders.add(order);
    }
  }

  List<EmployeeStats> toSortedEmployeeStats() {
    return _employeeStatsMap.values.toList()
      ..sort((a, b) => b.totalUnits.compareTo(a.totalUnits));
  }
}
