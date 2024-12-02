import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/helpers/date_extension.dart';
import 'package:meta/meta.dart';

import '../dashboard_repo/dashboard_repo.dart';

part 'dashboard_state.dart';
part 'helper.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository orderRepository = FirebaseOrderRepository();

  DashboardCubit() : super(DashboardInitial()) {
    _startDate = DateTime.now().startOfDay;
    _endDate = DateTime.now().endOfDay;

    getAllOrders();
  }

  late DateTime _startDate;
  late DateTime _endDate;

  get startDate => _startDate;
  get endDate => _endDate;
  setStartDate(DateTime date) {
    _startDate = date.startOfDay;
    emit(DashboardSuccess());
  }

  setEndDate(DateTime date) {
    _endDate = date.endOfDay;
    emit(DashboardSuccess());
  }

  List<OrderModel> allOrders = [];
  ReportMainStats statistics = ReportMainStats();
  List<ProductStats> productStats = [];
  List<EmployeeStats> employeesStats = [];

  Future<void> getAllOrders() async {
    try {
      emit(DashboardLoading());
      allOrders = await orderRepository.getOrdersByDateRange(
          startDate: startDate, endDate: endDate);

      _calculateAllStats();

      return emit(DashboardSuccess());
    } on FirebaseException catch (e) {
      return emit(
        DashboardFailure(FirebaseFailure.fromFirebaseException(e).errMsg),
      );
    } catch (e) {
      Failure.exception(e);
      return emit(DashboardFailure("حدث خطأ!!"));
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
    employeesStats = employeeStatsContainer.toSortedEmployeeStats();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    Injector.unregister<DashboardCubit>();
    return super.close();
  }
}
