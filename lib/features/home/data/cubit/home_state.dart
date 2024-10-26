part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeProductsState extends HomeState {
  HomeProductsState();
}

final class HomeFailure extends HomeState {
  final String errMsg;

  HomeFailure(this.errMsg);
}

final class InternetState extends HomeState {
  InternetState();

  void connectionBanner(BuildContext context) {
    !Injector.isOnline
        ? ShowInfoUtil.showMaterialBanner(context, msg: "لا يوجد انترنت")
        : ShowInfoUtil.hideCurrentMaterialBanner(context);
  }
}
