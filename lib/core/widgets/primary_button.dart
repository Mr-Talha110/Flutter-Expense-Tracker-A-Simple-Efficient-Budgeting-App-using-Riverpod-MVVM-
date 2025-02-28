import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/core/utils/extensions/opacity_extension.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final bool isLoading;
  final bool isDisable;
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.margin,
    required this.text,
    this.bgColor,
    this.isLoading = false,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0.0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide.none,
            ),
          ),
          padding:
              WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 14)),
          backgroundColor: WidgetStatePropertyAll(
            isDisable ? AppColors.lightGrey : bgColor ?? AppColors.pink,
          ),
        ),
        onPressed: isDisable ? () {} : onPressed,
        child: Text(
          text,
          style: AppTextStyle.bodyLarge.copyWith(
            color: isDisable
                ? AppColors.black.withCustomOpacity(0.50)
                : AppColors.black,
          ),
        ),
      ),
    );
  }
}
