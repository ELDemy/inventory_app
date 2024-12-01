import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:meta/meta.dart';

import '../dashboard_repo/dashboard_repo.dart';

part 'dashboard_state.dart';
part 'helper.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository orderRepository = FirebaseOrderRepository();

  DashboardCubit() : super(DashboardInitial());

  List<OrderModel> allOrders = [];
  ReportMainStats statistics = ReportMainStats();
  List<ProductStats> productStats = [];
  List<EmployeeStats> employeeStats = [];

  Future<void> getAllOrders(DateTime startDate, DateTime endDate) async {
    try {
      emit(DashboardLoading());
      allOrders = await orderRepository.getOrdersByDateRange(
          startDate: startDate, endDate: endDate);

      _calculateAllStats();

      emit(DashboardSuccess());
    } catch (e) {
      emit(DashboardFailure(e.toString()));
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
