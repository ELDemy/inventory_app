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

class ReportStatistics {
  final int totalOrders;
  final int totalProducts;
  final double totalRevenue;
  final int totalUnits;
  final int uniqueCustomers;

  ReportStatistics({
    this.totalOrders = 0,
    this.totalProducts = 0,
    this.totalRevenue = 0,
    this.totalUnits = 0,
    this.uniqueCustomers = 0,
  });
}
