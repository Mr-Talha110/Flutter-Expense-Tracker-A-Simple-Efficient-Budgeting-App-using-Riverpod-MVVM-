import 'package:expense_tracker_app/core/utils/app_router.dart';
import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const PrimaryAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.transparent,
      title: Text(
        title ?? '',
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.mainTitle,
      ),
      elevation: 0.0,
      leading: IconButton(
        onPressed: AppRouter.pop,
        icon: SvgPicture.asset(AppAssets.backArrowIcon),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
