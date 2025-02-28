import 'dart:ui';

import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';

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

List<ExpenseChartModel> processData(
    List<ExpenseTransactionModel> transactions) {
  final Map<int, double> intervalAmounts = {};
  double totalSpending = 0;

  for (var transaction in transactions) {
    totalSpending += transaction.amount;
  }

  final intervals = [1, 5, 10, 15, 20, 25, 30];
  for (var transaction in transactions) {
    final day = transaction.date.day;
    int interval = intervals.firstWhere(
      (interval) => day >= interval && day < interval + 5,
      orElse: () => 30,
    );
    intervalAmounts[interval] =
        (intervalAmounts[interval] ?? 0) + transaction.amount;
  }
  return intervals.map((interval) {
    double amount = intervalAmounts[interval] ?? 0;
    double percentage = totalSpending > 0 ? (amount / totalSpending) * 100 : 0;

    return ExpenseChartModel(
      category: ShoppingTypeEnum.values[intervals.indexOf(interval)],
      amount: amount,
      color: ShoppingTypeEnum.values[intervals.indexOf(interval)].bgColor,
      percentage: percentage,
    );
  }).toList();
}
