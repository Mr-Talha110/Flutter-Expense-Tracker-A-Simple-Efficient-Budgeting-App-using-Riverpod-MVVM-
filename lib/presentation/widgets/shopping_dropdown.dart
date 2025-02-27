import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/core/extensions/opacity_extension.dart';
import 'package:expense_tracker_app/core/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/add_transaction_fields_providers.dart';
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
      height: 500,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: GridView.builder(
        itemCount: shoppingTypes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onItemSelected != null
              ? () {
                  ref.read(shoppingDropdownProvider.notifier).state = false;
                  onItemSelected!(index);
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderBlue),
              color: shoppingTypes[index].bgColor.withCustomOpacity(0.50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(shoppingTypes[index].icon),
                10.horizontal,
                Text(shoppingTypes[index].title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
