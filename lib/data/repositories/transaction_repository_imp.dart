import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/failure.dart';
import 'package:expense_tracker_app/data/datasources/local_datasource.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository.dart';
import 'package:get_it/get_it.dart';

class TransactionRepositoryImp extends TransactionRepository {
  @override
  Future<Either<Failure, bool>> saveExpenseTransaction(
    ExpenseTrackModel expenseInfo,
  ) async {
    try {
      LocalDatasource localDataSource = GetIt.instance<LocalDatasource>();
      await localDataSource.storeList(
        localDataSource.transactionsBox,
        localDataSource.transactionsKey,
        expenseInfo,
      );
      return right(true);
    } catch (e) {
      log('error saving transaction $e');
      return left(Failure(AppStrings.saveTransactionFailed));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseTrackModel>>>
      fetchExpenseTransaction() async {
    try {
      LocalDatasource localDataSource = GetIt.instance<LocalDatasource>();
      List<ExpenseTrackModel> txList = await localDataSource.fetchList(
        localDataSource.transactionsBox,
        localDataSource.transactionsKey,
      );
      return right(txList);
    } catch (e) {
      log('error fetching transaction $e');
      return left(Failure(AppStrings.saveTransactionFailed));
    }
  }
}
