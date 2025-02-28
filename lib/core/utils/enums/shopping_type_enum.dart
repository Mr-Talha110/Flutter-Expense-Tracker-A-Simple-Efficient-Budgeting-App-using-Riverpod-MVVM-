import 'dart:ui';

import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:hive/hive.dart';

part 'shopping_type_enum.g.dart'; // Generated file

@HiveType(typeId: 1) // Unique typeId for this enum
enum ShoppingTypeEnum {
  @HiveField(0)
  foodAndDrink('foodAndDrink'),

  @HiveField(1)
  transport('transport'),

  @HiveField(2)
  lifestyle('lifestyle'),

  @HiveField(3)
  health('health'),

  @HiveField(4)
  education('education'),

  @HiveField(5)
  apparel('apparel'),

  @HiveField(6)
  internet('internet'),

  @HiveField(7)
  shopping('shopping'),

  @HiveField(8)
  charity('charity'),

  @HiveField(9)
  pets('pets'),

  @HiveField(10)
  socialLife('socialLife'),

  @HiveField(11)
  phone('phone'),

  @HiveField(12)
  fun('fun'),

  @HiveField(13)
  gifts('gifts');

  const ShoppingTypeEnum(this.value);
  final String value;

  factory ShoppingTypeEnum.fromValue(String value) {
    return values.firstWhere(
      (element) => element.value == value,
    );
  }

  String get title {
    switch (this) {
      case ShoppingTypeEnum.foodAndDrink:
        return 'Food & Drink';
      case ShoppingTypeEnum.transport:
        return 'Transport';
      case ShoppingTypeEnum.lifestyle:
        return 'Lifestyle';
      case ShoppingTypeEnum.health:
        return 'Health';
      case ShoppingTypeEnum.education:
        return 'Education';
      case ShoppingTypeEnum.apparel:
        return 'Apparel';
      case ShoppingTypeEnum.gifts:
        return 'Gifts';
      case ShoppingTypeEnum.internet:
        return 'Internet';
      case ShoppingTypeEnum.shopping:
        return 'Shopping';
      case ShoppingTypeEnum.charity:
        return 'Charity';
      case ShoppingTypeEnum.pets:
        return 'Pets';
      case ShoppingTypeEnum.socialLife:
        return 'Social Life';
      case ShoppingTypeEnum.phone:
        return 'Phone';
      default:
        return 'Fun';
    }
  }

  String get icon {
    switch (this) {
      case ShoppingTypeEnum.foodAndDrink:
        return AppAssets.foodIcon;
      case ShoppingTypeEnum.transport:
        return AppAssets.transportIcon;
      case ShoppingTypeEnum.lifestyle:
        return AppAssets.lifestyleIcon;
      case ShoppingTypeEnum.health:
        return AppAssets.healthIcon;
      case ShoppingTypeEnum.education:
        return AppAssets.eductionIcon;
      case ShoppingTypeEnum.apparel:
        return AppAssets.shirtIcon;
      case ShoppingTypeEnum.gifts:
        return AppAssets.giftIcon;
      case ShoppingTypeEnum.internet:
        return AppAssets.internetIcon;
      case ShoppingTypeEnum.shopping:
        return AppAssets.shoppingIcon;
      case ShoppingTypeEnum.charity:
        return AppAssets.charityIcon;
      case ShoppingTypeEnum.pets:
        return AppAssets.petIcon;
      case ShoppingTypeEnum.socialLife:
        return AppAssets.socialIcon;
      case ShoppingTypeEnum.phone:
        return AppAssets.phoneIcon;
      default:
        return AppAssets.funIcon;
    }
  }

  Color get bgColor {
    switch (this) {
      case ShoppingTypeEnum.foodAndDrink:
        return AppColors.lightGreen;
      case ShoppingTypeEnum.transport:
        return AppColors.lightPink;
      case ShoppingTypeEnum.lifestyle:
        return AppColors.lightRed;
      case ShoppingTypeEnum.health:
        return AppColors.mediumBlue;
      case ShoppingTypeEnum.education:
        return AppColors.lightYellow;
      case ShoppingTypeEnum.apparel:
        return AppColors.mediumGreen;
      case ShoppingTypeEnum.gifts:
        return AppColors.purple;
      case ShoppingTypeEnum.internet:
        return AppColors.pink;
      case ShoppingTypeEnum.shopping:
        return AppColors.cream;
      case ShoppingTypeEnum.charity:
        return AppColors.lightRed;
      case ShoppingTypeEnum.pets:
        return AppColors.mediumBlue;
      case ShoppingTypeEnum.socialLife:
        return AppColors.lightYellow;
      case ShoppingTypeEnum.phone:
        return AppColors.lightRed;
      default:
        return AppColors.lightBlue;
    }
  }
}
