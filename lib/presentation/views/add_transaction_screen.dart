import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/core/extensions/space_extension.dart';
import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_fonts.dart';
import 'package:expense_tracker_app/core/utils/app_strings.dart';
import 'package:expense_tracker_app/core/utils/app_text_style.dart';
import 'package:expense_tracker_app/core/utils/methods.dart';
import 'package:expense_tracker_app/core/utils/validations.dart';
import 'package:expense_tracker_app/core/widgets/primary_app_bar.dart';
import 'package:expense_tracker_app/core/widgets/primary_button.dart';
import 'package:expense_tracker_app/core/widgets/primary_text_field.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/add_transaction_fields_providers.dart';
import 'package:expense_tracker_app/presentation/view_models/providers/add_transaction_notifier_provider.dart';
import 'package:expense_tracker_app/presentation/widgets/amount_text_field.dart';
import 'package:expense_tracker_app/presentation/widgets/custom_dropdown.dart';
import 'package:expense_tracker_app/presentation/widgets/shopping_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final GlobalKey<FormState> transactionFormKey = GlobalKey<FormState>();

class AddTransactionScreen extends ConsumerWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountController = ref.watch(amountControllerProvider);
    final notesController = ref.watch(notesTextProvider);
    final shoppingType = ref.watch(shoppingTypeProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return PopScope(
      onPopInvokedWithResult: (_, __) =>
          ref.read(addTransactionNotifierProvider.notifier).clearData(),
      child: Scaffold(
        appBar: PrimaryAppBar(title: AppStrings.addTransaction),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              if (ref.watch(shoppingDropdownProvider))
                Positioned(
                  left: 187,
                  top: 45,
                  child: Stack(
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
                  ),
                ),
              if (ref.watch(shoppingDropdownProvider))
                Container(
                  width: 187,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              Form(
                key: transactionFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            onTap: () => ref
                                    .read(shoppingDropdownProvider.notifier)
                                    .state =
                                !ref
                                    .read(shoppingDropdownProvider.notifier)
                                    .state,
                            title: AppStrings.shopping,
                            icon: AppAssets.cartIcon,
                            bgColor: AppColors.lightBlue,
                          ),
                        ),
                        10.horizontal,
                        Expanded(
                          child: CustomDropdown(
                            title: AppStrings.cash,
                            icon: AppAssets.cashIcon,
                            bgColor: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                    30.vertical,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AmountTextField(
                        onChanged: (value) {
                          ref
                              .read(amountControllerProvider.notifier)
                              .state
                              .text = value;
                        },
                        controller: amountController,
                        hintText: AppStrings.amountHintText,
                        validator: validateNumber,
                      ),
                    ),
                    30.vertical,
                    GestureDetector(
                      onTap: () => pickDate(
                        context,
                        (dateTime) => ref
                            .read(selectedDateProvider.notifier)
                            .state = dateTime,
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.lightGrey,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppAssets.dateIcon),
                            12.horizontal,
                            Text(
                              selectedDate == null
                                  ? AppStrings.date
                                  : formatDate(selectedDate),
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.darkGrey),
                            ),
                            Spacer(),
                            Text(
                              selectedDate == null
                                  ? ''
                                  : formatTime(selectedDate),
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.darkGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    18.vertical,
                    PrimaryTextField(
                      hintText: AppStrings.note,
                      controller: TextEditingController(
                        text: ref.watch(notesTextProvider),
                      ),
                      onChanged: (value) {
                        ref.read(notesTextProvider.notifier).state = value;
                      },
                      prefixIcon: AppAssets.notesIcon,
                    ),
                    18.vertical,
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.labelIcon),
                        12.horizontal,
                        Text(AppStrings.labels, style: AppTextStyle.bodyLarge),
                      ],
                    ),
                    13.vertical,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Text(
                              AppStrings.label,
                              style: AppTextStyle.bodyLarge.copyWith(
                                fontSize: 16,
                                fontFamily: AppFonts.robotoRegular,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    18.vertical,
                    CustomDropdown(
                      title: AppStrings.recurrance,
                      icon: AppAssets.recurringIcon,
                      bgColor: AppColors.lightGrey,
                      selectedOpt: 'Never',
                    )
                  ],
                ),
              ),
              if (ref.watch(shoppingDropdownProvider))
                Positioned(
                  top: 65,
                  child: ShoppingDropdown(
                    onItemSelected: (index) => ref
                        .read(shoppingTypeProvider.notifier)
                        .state = shoppingTypes[index],
                    shoppingTypes: shoppingTypes,
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: PrimaryButton(
            isDisable: amountController.text.isEmpty ||
                selectedDate == null ||
                notesController.isEmpty ||
                shoppingType == null,
            text: AppStrings.add,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            onPressed: () {
              ExpenseTrackModel expenseTrackModel = ExpenseTrackModel(
                amount: parseDouble(amountController.text.trim()) ?? 0,
                date: selectedDate ?? DateTime.now(),
                note: notesController,
                shoppingType: shoppingType ?? ShoppingTypeEnum.fun,
              );
              ref
                  .read(addTransactionNotifierProvider.notifier)
                  .saveTransaction(expenseTrackModel);
            },
          ),
        ),
      ),
    );
  }
}

final List<ShoppingTypeEnum> shoppingTypes = [
  ShoppingTypeEnum.foodAndDrink,
  ShoppingTypeEnum.transport,
  ShoppingTypeEnum.lifestyle,
  ShoppingTypeEnum.health,
  ShoppingTypeEnum.education,
  ShoppingTypeEnum.apparel,
  ShoppingTypeEnum.gifts,
  ShoppingTypeEnum.internet,
  ShoppingTypeEnum.shopping,
  ShoppingTypeEnum.charity,
  ShoppingTypeEnum.pets,
  ShoppingTypeEnum.socialLife,
  ShoppingTypeEnum.phone,
  ShoppingTypeEnum.fun,
];
