import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/popups.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class TransactionListViewModel
    extends StateNotifier<ApiResponse<List<ExpenseTrackModel>>> {
  final Ref ref;
  TransactionListViewModel({required this.ref})
      : super(
          ApiResponse.idle('Initial state'),
        );

  List<ExpenseTrackModel> get txList => state.data ?? [];

  void _updateState(ApiResponse<List<ExpenseTrackModel>> newState) {
    if (mounted) {
      state = newState;
    }
  }

  fetchTransactions() async {
    _updateState(ApiResponse.loading('Loading Transactions'));
    final transactionRepository = GetIt.instance<TransactionRepositoryImp>();
    await transactionRepository.fetchExpenseTransaction().then(
          (value) => value.fold(
            (error) {
              _updateState(ApiResponse.error(error.message));
              ToastOverlay.showToast(AppStrings.fetchTransactionFailed);
            },
            (result) {
              _updateState(ApiResponse.completed(result));
            },
          ),
        );
  }

  void addTransaction(ExpenseTrackModel expenseModel) {
    if (state.status == LoadStatus.completed && state.data != null) {
      final updatedList = List<ExpenseTrackModel>.from(state.data!)
        ..add(expenseModel);
      _updateState(ApiResponse.completed(updatedList));
    }
  }
}
