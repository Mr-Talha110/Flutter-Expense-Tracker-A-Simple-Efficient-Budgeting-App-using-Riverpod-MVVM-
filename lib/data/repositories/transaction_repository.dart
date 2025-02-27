import 'package:dartz/dartz.dart';
import 'package:expense_tracker_app/core/utils/failure.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure, bool>> saveExpenseTransaction(
    ExpenseTransactionModel expenseInfo,
  );
  Future<Either<Failure, bool>> updateExpenseTransaction(
    ExpenseTransactionModel expenseInfo,
  );
  Future<Either<Failure, bool>> deleteExpenseTransaction(
    String txId,
  );
  Future<Either<Failure, List<ExpenseTransactionModel>>>
      fetchExpenseTransaction();
}
