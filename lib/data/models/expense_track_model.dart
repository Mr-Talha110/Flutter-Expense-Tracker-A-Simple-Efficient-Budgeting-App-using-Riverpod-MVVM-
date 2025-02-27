// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:hive/hive.dart';

part 'expense_track_model.g.dart';

@HiveType(typeId: 0)
class ExpenseTrackModel {
  @HiveField(0)
  final ShoppingTypeEnum shoppingType;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final DateTime date;

  ExpenseTrackModel({
    required this.shoppingType,
    required this.amount,
    required this.note,
    required this.date,
  });

  @override
  String toString() {
    return 'ExpenseTrackModel(shoppingType: $shoppingType, amount: $amount, note: $note, date: $date)';
  }
}
