import 'package:flutter_riverpod/flutter_riverpod.dart';

// final amountControllerProvider = StateProvider<TextEditingController>((ref) {
//   return TextEditingController();
// });
// final notesControllerProvider = StateProvider<TextEditingController>((ref) {
//   return TextEditingController();
// });

// final shoppingTypeProvider = StateProvider<ShoppingTypeEnum?>((ref) => null);

// final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

final shoppingDropdownProvider = StateProvider<bool>((ref) => false);
