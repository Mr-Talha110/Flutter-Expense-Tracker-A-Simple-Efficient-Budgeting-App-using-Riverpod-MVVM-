import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/core/utils/extensions/opacity_extension.dart';
import 'package:expense_tracker_app/core/utils/extensions/space_extension.dart';
import 'package:expense_tracker_app/presentation/views/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ShoppingDropdown extends ConsumerWidget {
  final List<ShoppingTypeEnum> shoppingTypes;
  final Function(int)? onItemSelected;
  const ShoppingDropdown({
    super.key,
    required this.shoppingTypes,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: shoppingTypes.map((shoppingType) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onItemSelected != null
                ? () {
                    ref.read(shoppingDropdownProvider.notifier).state = false;
                    onItemSelected!(shoppingTypes.indexOf(shoppingType));
                  }
                : null,
            child: Container(
              width: (MediaQuery.of(context).size.width * 0.95 - 30) / 2,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderBlue),
                color: shoppingType.bgColor.withCustomOpacity(0.50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(shoppingType.icon),
                  10.horizontal,
                  Text(shoppingType.title),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
