import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/presentation/view_models/transaction_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TRANSACTION STATE NOTIFIER PROVIDER
final transactionNotifierProvider = StateNotifierProvider<
    TransactionListViewModel, ApiResponse<List<ExpenseTransactionModel>>>(
  (ref) => TransactionListViewModel(ref: ref),
);
