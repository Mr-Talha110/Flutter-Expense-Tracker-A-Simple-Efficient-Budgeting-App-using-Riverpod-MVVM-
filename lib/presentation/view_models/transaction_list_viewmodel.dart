import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/popups.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class TransactionListViewModel
    extends StateNotifier<ApiResponse<List<ExpenseTransactionModel>>> {
  final Ref ref;
  TransactionListViewModel({required this.ref})
      : super(ApiResponse.idle('Initial state'));

  //STATE GETTER
  List<ExpenseTransactionModel> get txList => state.data ?? [];

  final transactionRepository = GetIt.instance<TransactionRepositoryImp>();

  void _updateState(ApiResponse<List<ExpenseTransactionModel>> newState) {
    if (mounted) {
      state = newState;
    }
  }

  //FETCH TRANSACTIONS
  fetchTransactions() async {
    _updateState(ApiResponse.loading('Loading Transactions'));
    await transactionRepository.fetchExpenseTransaction().then(
          (value) => value.fold(
            (error) {
              _updateState(ApiResponse.error(error.message));
              ToastOverlay.showToast(AppStrings.fetchTransactionFailed);
            },
            (result) {
              result.sort((a, b) => a.date.compareTo(b.date));
              _updateState(ApiResponse.completed(result));
            },
          ),
        );
  }

  void addTransaction(ExpenseTransactionModel expenseModel) async {
    if (state.status == LoadStatus.completed && state.data != null) {
      final updatedList = List<ExpenseTransactionModel>.from(state.data!);
      final existingIndex = updatedList
          .indexWhere((transaction) => transaction.txId == expenseModel.txId);
      if (existingIndex != -1) {
        updatedList[existingIndex] = expenseModel;
      } else {
        updatedList.add(expenseModel);
      }
      updatedList.sort((a, b) => a.date.compareTo(b.date));

      _updateState(ApiResponse.completed(updatedList));
    }
  }

  void deleteTransaction(String txId) async {
    if (state.status == LoadStatus.completed && state.data != null) {
      final updatedList = List<ExpenseTransactionModel>.from(state.data!);
      final existingIndex =
          updatedList.indexWhere((transaction) => transaction.txId == txId);
      if (existingIndex != -1) {
        await transactionRepository.deleteExpenseTransaction(txId).then(
              (value) => value.fold(
                (error) => ToastOverlay.showToast(error.message),
                (result) {
                  updatedList.removeAt(existingIndex);
                  _updateState(ApiResponse.completed(updatedList));
                },
              ),
            );
      }
    }
  }

  //EXPENSE CHART METHODS
  String getTotalExpense() {
    if (state.status == LoadStatus.completed && state.data != null) {
      double expense = 0;
      for (var item in state.data!) {
        expense = expense + item.amount;
      }
      return expense.toString();
    }
    return '';
  }

  bool isDifferentDay({required int index}) {
    if (index == 0) {
      return true;
    }
    final previousTrans = state.data![index - 1];
    final currentTrans = state.data![index];
    final previousDate = previousTrans.date.day;
    final currentDate = currentTrans.date.day;
    if (currentDate != previousDate) {
      return true;
    }
    return false;
  }

  String formateChatDate(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(time.year, time.month, time.day);
    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, yyyy').format(time);
    }
  }

  String getTotalAmountForDate(DateTime date) {
    if (state.status == LoadStatus.completed && state.data != null) {
      final filteredTransactions = state.data!.where((transaction) {
        final transactionDate = DateTime(
          transaction.date.year,
          transaction.date.month,
          transaction.date.day,
        );
        final targetDate = DateTime(date.year, date.month, date.day);
        return transactionDate == targetDate;
      }).toList();
      double totalAmount = 0;
      for (var transaction in filteredTransactions) {
        totalAmount += transaction.amount;
      }
      return totalAmount.toString();
    }
    return '0';
  }
}
