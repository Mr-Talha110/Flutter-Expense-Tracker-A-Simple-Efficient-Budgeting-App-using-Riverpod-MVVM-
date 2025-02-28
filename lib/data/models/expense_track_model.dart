import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';
import 'package:hive/hive.dart';

part 'expense_track_model.g.dart';

@HiveType(typeId: 0)
class ExpenseTransactionModel {
  @HiveField(0)
  final ShoppingTypeEnum shoppingType;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String txId;

  ExpenseTransactionModel({
    required this.shoppingType,
    required this.amount,
    required this.note,
    required this.date,
    required this.txId,
  });

  @override
  String toString() {
    return 'ExpenseTrackModel(shoppingType: $shoppingType, amount: $amount, note: $note, date: $date, txID: $txId)';
  }
}
