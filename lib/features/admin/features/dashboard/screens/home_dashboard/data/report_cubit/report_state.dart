part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportSuccess extends ReportState {}

final class ReportFailure extends ReportState {
  final String errMsg;

  ReportFailure(this.errMsg);
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

  ProductStats({
    required this.productModel,
    required this.totalUnits,
    required this.totalRevenue,
  });
}

class EmployeeStats {
  final String employeeName;
  int totalUnits;
  num totalRevenue;

  EmployeeStats({
    required this.employeeName,
    required this.totalUnits,
    required this.totalRevenue,
  });
}
