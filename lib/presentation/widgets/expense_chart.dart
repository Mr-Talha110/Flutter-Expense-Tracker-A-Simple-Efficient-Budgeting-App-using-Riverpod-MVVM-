import 'dart:math';

import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/data/models/expense_chart_model.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final List<ExpenseChartModel> chartData;

  const _BarChart({required this.chartData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: chartData.map((data) {
          return BarChartGroupData(
            x: chartData.indexOf(data),
            barRods: [
              BarChartRodData(
                toY: data.amount + 2,
                width: 16,
                color: data.color,
                borderRadius: BorderRadius.circular(11),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: chartData.map((data) => data.amount).reduce(max) *
            1.2, // Add padding
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => AppColors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            final data = chartData[groupIndex];
            return BarTooltipItem(
              '${data.percentage.toStringAsFixed(1)}%',
              const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            );
          },
        ),
      );
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.mediumGrey,
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
    final intervals = [1, 5, 10, 15, 20, 25, 30];
    final interval = intervals[value.toInt()];
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(interval.toString(), style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey,
            width: 1,
          ),
        ),
      );
}

class ExpenseChart extends StatefulWidget {
  final List<ExpenseTransactionModel> transactions;

  const ExpenseChart({super.key, required this.transactions});

  @override
  State<StatefulWidget> createState() => ExpenseChartState();
}

class ExpenseChartState extends State<ExpenseChart> {
  List<ExpenseChartModel> chartData = [];

  @override
  Widget build(BuildContext context) {
    chartData = processData(widget.transactions);
    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _BarChart(chartData: chartData),
      ),
    );
  }
}
