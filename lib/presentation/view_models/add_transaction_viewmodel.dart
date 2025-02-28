import 'package:expense_tracker_app/core/routes/app_router.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/popups.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository_imp.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/transaction_list_notifier_provider.dart';
import 'package:expense_tracker_app/presentation/views/add_transaction_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class AddTransactionsViewModel extends StateNotifier<String> {
  final Ref ref;
  AddTransactionsViewModel({required this.ref}) : super('');

  final _transactionRepository = GetIt.instance<TransactionRepositoryImp>();

  saveTransaction(
    ExpenseTransactionModel expenseModel, {
    bool isUpdate = false,
  }) async {
    if (!transactionFormKey.currentState!.validate()) return;
    if (isUpdate) {
      await _transactionRepository.updateExpenseTransaction(expenseModel).then(
            (value) => value.fold(
              (error) => ToastOverlay.showToast(error.message),
              (result) {
                AppRouter.pop();
                ref
                    .read(transactionListNotifierProvider.notifier)
                    .addTransaction(expenseModel);
                ToastOverlay.showToast(AppStrings.transactionUpdated);
              },
            ),
          );
      return;
    }
    await _transactionRepository.saveExpenseTransaction(expenseModel).then(
          (value) => value.fold(
            (error) => ToastOverlay.showToast(error.message),
            (result) {
              AppRouter.pop();
              ref
                  .read(transactionListNotifierProvider.notifier)
                  .addTransaction(expenseModel);
              ToastOverlay.showToast(AppStrings.transactionSaved);
            },
          ),
        );
  }
}
