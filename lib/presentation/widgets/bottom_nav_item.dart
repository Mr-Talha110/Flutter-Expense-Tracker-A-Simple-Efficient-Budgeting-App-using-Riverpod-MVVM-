import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final bool secondItem;
  final bool isSelected;
  const BottomNavItem({
    super.key,
    required this.icon,
    this.onTap,
    this.isSelected = false,
    this.secondItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: secondItem ? 60 : 0),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.black : AppColors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
