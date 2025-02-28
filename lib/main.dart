import 'package:expense_tracker_app/core/utils/app_router.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/app_theme.dart';
import 'package:expense_tracker_app/data/datasources/local_datasource.dart';
import 'package:expense_tracker_app/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatasource.init();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: appTheme,
        navigatorKey: AppRouter.key,
        initialRoute: AppRouter.bottomNavigation,
        onGenerateRoute: AppRouter.generateRoutes,
      ),
    );
  }
}
