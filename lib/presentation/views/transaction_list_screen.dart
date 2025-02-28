import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_router.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/core/utils/extensions/space_extension.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/transaction_notifier_provider.dart';
import 'package:expense_tracker_app/presentation/widgets/expense_chart.dart';
import 'package:expense_tracker_app/presentation/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionlistScreen extends ConsumerStatefulWidget {
  const TransactionlistScreen({super.key});

  @override
  ConsumerState<TransactionlistScreen> createState() =>
      _TransactionlistScreenState();
}

class _TransactionlistScreenState extends ConsumerState<TransactionlistScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(transactionNotifierProvider.notifier).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionNotifierProvider);
    final transactionListProvider =
        ref.read(transactionNotifierProvider.notifier);
    transactionListProvider.processData(transactionListProvider.txList);

    //SWITCH CASE FOR MANAGE WIDGET ACCORDING TO STATE STATUS
    switch (state.status) {
      case LoadStatus.idle:
        return Center(
          child: CircularProgressIndicator(color: AppColors.pink),
        );
      case LoadStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: AppColors.pink),
        );
      case LoadStatus.error:
        return Center(
          child: Text('Error: ${state.message}'),
        );
      case LoadStatus.completed:
        return state.data!.isEmpty
            ? Center(child: Text(AppStrings.noTxFound))
            : SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      14.vertical,
                      Text(
                        '-£${transactionListProvider.getTotalExpense()}',
                        style: AppTextStyle.mainTitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      27.vertical,
                      ExpenseChart(
                        transactions: transactionListProvider.txList,
                      ),
                      16.vertical,
                      Expanded(
                        child: RefreshIndicator.adaptive(
                          color: AppColors.black,
                          onRefresh: () async =>
                              transactionListProvider.fetchTransactions(),
                          child: ListView.builder(
                            itemCount: state.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  //WIDGETS FOR SEPERATE THE LIST ITEM ACCORDING TO DATE
                                  if (transactionListProvider.isDifferentDay(
                                      index: index))
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 11,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.lowBlue,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            transactionListProvider
                                                .formateChatDate(
                                              state.data![index].date,
                                            ),
                                            style: TextStyle(
                                                color: AppColors.neutralGrey),
                                          ),
                                          Text(
                                            '-£${transactionListProvider.getTotalAmountForDate(state.data![index].date)}',
                                            style: TextStyle(
                                              color: AppColors.neutralGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  TransactionItem(
                                    tx: state.data![index],
                                    onTap: () => AppRouter.push(
                                      AppRouter.addTransaction,
                                      arguments: state.data![index],
                                    ),
                                    onDelTap: () => transactionListProvider
                                        .deleteTransaction(
                                      state.data![index].txId,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      default:
        return Center(child: Text('UNKOWN STATE'));
    }
  }
}
