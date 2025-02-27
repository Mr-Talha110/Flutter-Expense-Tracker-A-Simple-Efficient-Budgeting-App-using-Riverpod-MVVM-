import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final amountControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final notesTextProvider = StateProvider<String>((ref) => '');

final shoppingTypeProvider = StateProvider<ShoppingTypeEnum?>((ref) => null);

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

final shoppingDropdownProvider = StateProvider<bool>((ref) => false);
