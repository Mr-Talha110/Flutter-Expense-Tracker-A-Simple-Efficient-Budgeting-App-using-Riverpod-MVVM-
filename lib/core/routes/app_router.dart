import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/presentation/views/add_transaction_screen.dart';
import 'package:expense_tracker_app/presentation/views/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  //ROUTES NAMING
  static const bottomNavigation = '/';
  static const addTransaction = 'add-transaction';

  //NAVIGATOR HELPERS
  static final key = GlobalKey<NavigatorState>();
  static String currentRoute = bottomNavigation;

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final params = settings.arguments;
    currentRoute = settings.name.toString();
    switch (settings.name) {
      case bottomNavigation:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationScreen(),
        );
      case addTransaction:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AddTransactionScreen(
            expenseInfo: params as ExpenseTransactionModel?,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
    }
  }

  //NAVIGATIONS METHODS
  static pushAndReplace(String route, {Object? arguments}) {
    key.currentState!
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
    key.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static pushAndReplaceAll(String route, {Object? arguments}) {
    key.currentState!.pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static popAndPush(String route, {Object? arguments}) {
    pop();
    key.currentState!.pushNamed(route, arguments: arguments);
  }

  static Future push<T extends Object?>(String route,
      {Object? arguments}) async {
    final data = key.currentState!.pushNamed(route, arguments: arguments);
    return data;
  }

  static pop<T>([T? result]) {
    key.currentState!.pop(result);
    currentRoute = 'home';
  }

  static popTimes<T>(int count, [T? result]) {
    while (count != 0) {
      key.currentState!.pop(result);
      count--;
    }
  }

  static popUntilToFirst() =>
      key.currentState!.popUntil((route) => route.isFirst);

  static String get currentRouter => currentRoute;

  static void popUntilTo(String previousRoute) {
    key.currentState!.popUntil((route) => route.settings.name == previousRoute);
  }
}
