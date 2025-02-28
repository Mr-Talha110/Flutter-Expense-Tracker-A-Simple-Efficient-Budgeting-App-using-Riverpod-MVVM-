import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixIcon;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;

  const PrimaryTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: AppColors.black,
      controller: controller,
      onChanged: onChanged,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.bodyLarge.copyWith(color: AppColors.darkGrey),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        fillColor: AppColors.lightGrey,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Transform.translate(
                offset: Offset(0, -25),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    prefixIcon ?? '',
                  ),
                ),
              ),
      ),
    );
  }
}
