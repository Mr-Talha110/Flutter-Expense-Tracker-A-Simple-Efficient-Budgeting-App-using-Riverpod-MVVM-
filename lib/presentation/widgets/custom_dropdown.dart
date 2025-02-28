import 'package:expense_tracker_app/core/utils/extensions/opacity_extension.dart';
import 'package:expense_tracker_app/core/utils/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropdown extends StatelessWidget {
  final Color? bgColor;
  final String title;
  final String icon;
  final String? selectedOpt;
  final VoidCallback? onTap;
  const CustomDropdown({
    super.key,
    this.bgColor,
    this.selectedOpt,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: bgColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            10.horizontal,
            Text(
              title,
              style: AppTextStyle.bodyMedium,
            ),
            Spacer(),
            Visibility(
              visible: selectedOpt != null,
              child: Row(
                children: [
                  Text(
                    selectedOpt ?? '',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.black.withCustomOpacity(0.50),
                    ),
                  ),
                  12.horizontal,
                ],
              ),
            ),
            SvgPicture.asset(AppAssets.arrowDownIcon)
          ],
        ),
      ),
    );
  }
}
