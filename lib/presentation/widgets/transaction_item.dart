import 'package:expense_tracker_app/core/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_fonts.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionItem extends StatelessWidget {
  final ExpenseTrackModel tx;
  const TransactionItem({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: tx.shoppingType.bgColor,
            child: SvgPicture.asset(tx.shoppingType.icon),
          ),
          8.horizontal,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tx.shoppingType.title,
                style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.robotoMedium),
              ),
              4.vertical,
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.greish,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('Lunch'),
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
                    tx.note,
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
            '-£ ${tx.amount}',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.red,
              fontFamily: AppFonts.robotoRegular,
            ),
          )
        ],
      ),
    );
  }
}
