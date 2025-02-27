import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedCorner extends StatelessWidget {
  const RoundedCorner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
          ),
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
            ),
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}
