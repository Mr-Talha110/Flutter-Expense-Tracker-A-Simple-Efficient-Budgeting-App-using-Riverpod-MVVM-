import 'package:expense_tracker_app/core/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/api_response.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/transaction_list_notifier_provider.dart';
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
      ref.read(transactionListNotifierProvider.notifier).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionListNotifierProvider);

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
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                14.vertical,
                Text(
                  '-£31.26',
                  style: AppTextStyle.mainTitle
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                16.vertical,
                Expanded(
                  child: ListView.builder(
                    itemCount: state.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TransactionItem(tx: state.data![index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
