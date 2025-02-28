import 'package:expense_tracker_app/core/utils/extensions/opacity_extension.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AmountTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;

  const AmountTextField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
  });
  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final FocusNode _fieldNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) => setState(() {}),
      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        focusNode: _fieldNode,
        onTap: () => setState(() {}),
        controller: widget.controller,
        keyboardType: TextInputType.number,
        cursorWidth: 3,
        cursorHeight: 40,
        style: AppTextStyle.largeTitle,
        textAlign: TextAlign.center,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          hintText: widget.hintText ?? '',
          errorStyle: TextStyle(color: AppColors.red),
          hintStyle: AppTextStyle.largeTitle
              .copyWith(color: AppColors.black.withCustomOpacity(0.3)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
