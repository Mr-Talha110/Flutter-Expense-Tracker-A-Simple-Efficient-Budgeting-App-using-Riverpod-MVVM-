import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/core/utils/app_router.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/core/utils/popups.dart';
import 'package:expense_tracker_app/data/models/expense_chart_model.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository_imp.dart';
import 'package:expense_tracker_app/presentation/views/add_transaction_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class TransactionListViewModel
    extends StateNotifier<ApiResponse<List<ExpenseTransactionModel>>> {
  final Ref ref;
  TransactionListViewModel({required this.ref})
      : super(ApiResponse.idle('Initial state'));
  final _transactionRepository = GetIt.instance<TransactionRepositoryImp>();

  //STATE GETTER
  List<ExpenseTransactionModel> get txList => state.data ?? [];

  void _updateState(ApiResponse<List<ExpenseTransactionModel>> newState) {
    if (mounted) {
      state = newState;
    }
  }

  //READ TRANSACTIONS
  fetchTransactions() async {
    _updateState(ApiResponse.loading('Loading Transactions'));
    await _transactionRepository.fetchExpenseTransaction().then(
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

  //CREATE AND UPDATE TRANSACTIONS
  Future<void> saveTransaction(
    ExpenseTransactionModel expenseModel, {
    bool isUpdate = false,
  }) async {
    if (!transactionFormKey.currentState!.validate()) return;

    final repositoryCall = isUpdate
        ? _transactionRepository.updateExpenseTransaction(expenseModel)
        : _transactionRepository.saveExpenseTransaction(expenseModel);

    final result = await repositoryCall;
    result.fold(
      (error) => ToastOverlay.showToast(error.message),
      (success) {
        AppRouter.pop();
        addTransaction(expenseModel);
        ToastOverlay.showToast(
          isUpdate
              ? AppStrings.transactionUpdated
              : AppStrings.transactionSaved,
        );
      },
    );
  }

  void addTransaction(ExpenseTransactionModel expenseModel) {
    if (state.status == LoadStatus.completed) {
      final updatedList = List<ExpenseTransactionModel>.from(txList);
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

  //DELETE TRANSACTION
  void deleteTransaction(String txId) async {
    if (state.status == LoadStatus.completed) {
      final updatedList = List<ExpenseTransactionModel>.from(txList);
      final existingIndex =
          updatedList.indexWhere((transaction) => transaction.txId == txId);
      if (existingIndex != -1) {
        await _transactionRepository.deleteExpenseTransaction(txId).then(
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
    if (state.status == LoadStatus.completed) {
      double expense = 0;
      for (var item in txList) {
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
    final previousTrans = txList[index - 1];
    final currentTrans = txList[index];
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
    if (state.status == LoadStatus.completed) {
      final filteredTransactions = txList.where((transaction) {
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

  List<ExpenseChartModel> processData(
    List<ExpenseTransactionModel> transactions,
  ) {
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
      double percentage =
          totalSpending > 0 ? (amount / totalSpending) * 100 : 0;

      return ExpenseChartModel(
        category: ShoppingTypeEnum.values[intervals.indexOf(interval)],
        amount: amount,
        color: ShoppingTypeEnum.values[intervals.indexOf(interval)].bgColor,
        percentage: percentage,
      );
    }).toList();
  }
}
