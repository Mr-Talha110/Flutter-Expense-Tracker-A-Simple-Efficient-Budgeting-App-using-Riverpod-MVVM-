import 'package:expense_tracker_app/presentation/view_models/add_transaction_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addTransactionNotifierProvider =
    StateNotifierProvider<AddTransactionsViewModel, String>(
  (ref) => AddTransactionsViewModel(ref: ref),
);
