import 'package:go_router/go_router.dart';
import 'package:inventory_app/features/auth/presentation/signin.dart';
import 'package:inventory_app/features/home/presentation/home_screen.dart';
import 'package:inventory_app/features/home/presentation/widgets/serial_search_screen.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/add_new_product_screen.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/make_order_screen.dart';
import 'package:inventory_app/features/product_management/product_profile/presentation/product_profile_screen.dart';
import 'package:inventory_app/features/splash_screen/splash_screen.dart';
import 'package:inventory_app/features/user_management/presentation/sign_up_screen.dart';
import 'package:inventory_app/features/user_management/presentation/user_management_screen.dart';

abstract class AppRouter {
  static const String kHomeScreen = "/HomeScreen";
  static const String kSignInScreen = "/SignInScreen";
  static const String kSignUpScreen = "/SignUpScreen";
  static const String kAddNewProductScreen = "/AddNewProductScreen";
  static const String kMakeOrderScreen = "/MakeOrderScreen";
  static const String kProductProfileScreen = "/ProductProfileScreen";
  static const String kSerialSearchScreen = "/SerialSearchScreen";
  static const String kUserManagementScreen = "/UserManagementScreen";

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kHomeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: kSignInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: kSignUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: kUserManagementScreen,
        builder: (context, state) => const UserManagementScreen(),
      ),
      GoRoute(
        path: kProductProfileScreen,
        builder: (context, state) =>
            ProductProfileScreen(identifierSN: state.extra as String),
      ),
      GoRoute(
        path: kAddNewProductScreen,
        builder: (context, state) => const AddNewProductScreen(),
      ),
      GoRoute(
        path: kMakeOrderScreen,
        builder: (context, state) {
          return MakeOrderScreen(barcode: state.extra as String);
        },
      ),
      GoRoute(
        path: kSerialSearchScreen,
        builder: (context, state) {
          final onSubmit = state.extra as void Function(String barcode);
          return SerialSearchScreen(onSubmit);
        },
      ),
    ],
  );
}
