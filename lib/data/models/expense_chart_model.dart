import 'dart:ui';

import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';

class ExpenseChartModel {
  final ShoppingTypeEnum category;
  final double amount;
  final Color color;

  ExpenseChartModel({
    required this.category,
    required this.amount,
    required this.color,
  });
}

List<ExpenseChartModel> processData(
    List<ExpenseTransactionModel> transactions) {
  final Map<ShoppingTypeEnum, double> categoryAmounts = {};

  // Group transactions by category
  for (var transaction in transactions) {
    categoryAmounts[transaction.shoppingType] =
        (categoryAmounts[transaction.shoppingType] ?? 0) + transaction.amount;
  }

  // Create ChartData list for all categories
  return ShoppingTypeEnum.values.map((category) {
    double amount = categoryAmounts[category] ?? 0;
    Color color = category.bgColor;

    return ExpenseChartModel(
      category: category,
      amount: amount,
      color: color,
    );
  }).toList();
}
