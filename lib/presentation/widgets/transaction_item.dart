import 'package:expense_tracker_app/core/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_fonts.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class TransactionItem extends StatefulWidget {
  final ExpenseTransactionModel tx;
  final VoidCallback? onTap;
  final VoidCallback? onDelTap;

  const TransactionItem({
    super.key,
    this.onDelTap,
    required this.tx,
    this.onTap,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem>
    with SingleTickerProviderStateMixin {
  late SlidableController slidableController;

  @override
  void initState() {
    slidableController = SlidableController(this);
    super.initState();
  }

  @override
  void dispose() {
    slidableController.dispose();
    super.dispose();
  }

  onDelete() {
    if (widget.onDelTap != null) {
      slidableController.close();
      widget.onDelTap!();
    }
  }

  onTap() {
    if (widget.onTap != null) {
      slidableController.close();
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 1.5 / 5,
        children: [
          Spacer(),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.red,
              ),
              child: Icon(
                Icons.delete,
                color: AppColors.white,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: widget.tx.shoppingType.bgColor,
                child: SvgPicture.asset(widget.tx.shoppingType.icon),
              ),
              8.horizontal,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tx.shoppingType.title,
                    style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.robotoMedium),
                  ),
                  4.vertical,
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.bankIcon),
                      4.horizontal,
                      Text(
                        AppStrings.cashWallet,
                        style: AppTextStyle.bodySmall.copyWith(
                          fontFamily: AppFonts.robotoRegular,
                          fontSize: 14,
                          color: AppColors.neutralGrey,
                        ),
                      )
                    ],
                  ),
                  4.vertical,
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.penIcon),
                      4.horizontal,
                      Text(
                        widget.tx.note,
                        style: AppTextStyle.bodySmall.copyWith(
                          fontFamily: AppFonts.robotoRegular,
                          fontSize: 14,
                          color: AppColors.neutralGrey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                '-£ ${widget.tx.amount}',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.red,
                  fontFamily: AppFonts.robotoRegular,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
