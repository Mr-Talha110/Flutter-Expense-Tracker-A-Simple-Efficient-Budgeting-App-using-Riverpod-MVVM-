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
import 'package:expense_tracker_app/presentation/widgets/rounded_corner.dart';
import 'package:expense_tracker_app/presentation/widgets/shopping_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final GlobalKey<FormState> transactionFormKey = GlobalKey<FormState>();

class AddTransactionScreen extends ConsumerStatefulWidget {
  final ExpenseTransactionModel? expenseInfo;
  const AddTransactionScreen({super.key, this.expenseInfo});
  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  ShoppingTypeEnum? shoppingType;
  DateTime? selectedDate;

  @override
  void initState() {
    if (widget.expenseInfo != null) {
      amountController.text = widget.expenseInfo!.amount.toString();
      notesController.text = widget.expenseInfo!.note;
      selectedDate = widget.expenseInfo!.date;
      shoppingType = widget.expenseInfo!.shoppingType;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.expenseInfo == null
            ? AppStrings.addTransaction
            : AppStrings.updateTransaction,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            if (ref.watch(shoppingDropdownProvider))
              Positioned(
                left: MediaQuery.of(context).size.width * 0.461,
                top: 45,
                child: RoundedCorner(),
              ),
            if (ref.watch(shoppingDropdownProvider))
              Container(
                width: MediaQuery.of(context).size.width * 0.461,
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
                        setState(() {});
                      },
                      controller: amountController,
                      hintText: AppStrings.amountHintText,
                      validator: validateDouble,
                    ),
                  ),
                  30.vertical,
                  GestureDetector(
                    onTap: () => pickDate(
                      context,
                      (dateTime) => setState(() => selectedDate = dateTime),
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
                                : formatDate(selectedDate!),
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.darkGrey),
                          ),
                          Spacer(),
                          Text(
                            selectedDate == null
                                ? ''
                                : formatTime(selectedDate!),
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
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: notesController,
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                  onItemSelected: (index) =>
                      setState(() => shoppingType = shoppingTypes[index]),
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
              notesController.text.isEmpty ||
              shoppingType == null,
          text: widget.expenseInfo == null ? AppStrings.add : AppStrings.update,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          onPressed: () {
            ExpenseTransactionModel expenseTrackModel = ExpenseTransactionModel(
              txId: widget.expenseInfo?.txId ?? getRandomId(),
              amount: parseDouble(amountController.text.trim()) ?? 0,
              date: selectedDate ?? DateTime.now(),
              note: notesController.text.trim(),
              shoppingType: shoppingType ?? ShoppingTypeEnum.fun,
            );
            ref.read(addTransactionNotifierProvider.notifier).saveTransaction(
                  expenseTrackModel,
                  isUpdate: widget.expenseInfo != null,
                );
          },
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
