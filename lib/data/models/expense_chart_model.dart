import 'dart:ui';

import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';

class ExpenseChartModel {
  final ShoppingTypeEnum category;
  final double amount;
  final Color color;
  final double percentage;

  ExpenseChartModel({
    required this.category,
    required this.percentage,
    required this.amount,
    required this.color,
  });
}
