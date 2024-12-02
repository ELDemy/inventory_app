part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {}

final class DashboardFailure extends DashboardState {
  final String errMsg;

  DashboardFailure(this.errMsg);
}

class ReportMainStats {
  final int totalOrders;
  final int totalProducts;
  final double totalRevenue;
  final int totalUnits;
  final int uniqueCustomers;

  ReportMainStats({
    this.totalOrders = 0,
    this.totalProducts = 0,
    this.totalRevenue = 0,
    this.totalUnits = 0,
    this.uniqueCustomers = 0,
  });
}

class ProductStats {
  final ProductModel productModel;
  int totalUnits;
  num totalRevenue;
  List<OrderModel> orders;
  Set<String> uniqueClients;

  ProductStats({
    required this.productModel,
    required this.totalUnits,
    required this.totalRevenue,
    required this.orders,
    required this.uniqueClients,
  });
}

class EmployeeStats {
  final String employeeName;
  int totalUnits;
  num totalRevenue;
  Set<String> uniqueClients;
  Set<ProductModel> uniqueProducts;
  List<OrderModel> orders;

  EmployeeStats(
      {required this.employeeName,
      required this.totalUnits,
      required this.totalRevenue,
      required this.uniqueClients,
      required this.uniqueProducts,
      required this.orders});
}
