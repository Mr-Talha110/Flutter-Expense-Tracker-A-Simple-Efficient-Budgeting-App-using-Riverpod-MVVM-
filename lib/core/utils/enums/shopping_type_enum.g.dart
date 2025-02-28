// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingTypeEnumAdapter extends TypeAdapter<ShoppingTypeEnum> {
  @override
  final int typeId = 1;

  @override
  ShoppingTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShoppingTypeEnum.foodAndDrink;
      case 1:
        return ShoppingTypeEnum.transport;
      case 2:
        return ShoppingTypeEnum.lifestyle;
      case 3:
        return ShoppingTypeEnum.health;
      case 4:
        return ShoppingTypeEnum.education;
      case 5:
        return ShoppingTypeEnum.apparel;
      case 6:
        return ShoppingTypeEnum.internet;
      case 7:
        return ShoppingTypeEnum.shopping;
      case 8:
        return ShoppingTypeEnum.charity;
      case 9:
        return ShoppingTypeEnum.pets;
      case 10:
        return ShoppingTypeEnum.socialLife;
      case 11:
        return ShoppingTypeEnum.phone;
      case 12:
        return ShoppingTypeEnum.fun;
      case 13:
        return ShoppingTypeEnum.gifts;
      default:
        return ShoppingTypeEnum.foodAndDrink;
    }
  }

  @override
  void write(BinaryWriter writer, ShoppingTypeEnum obj) {
    switch (obj) {
      case ShoppingTypeEnum.foodAndDrink:
        writer.writeByte(0);
        break;
      case ShoppingTypeEnum.transport:
        writer.writeByte(1);
        break;
      case ShoppingTypeEnum.lifestyle:
        writer.writeByte(2);
        break;
      case ShoppingTypeEnum.health:
        writer.writeByte(3);
        break;
      case ShoppingTypeEnum.education:
        writer.writeByte(4);
        break;
      case ShoppingTypeEnum.apparel:
        writer.writeByte(5);
        break;
      case ShoppingTypeEnum.internet:
        writer.writeByte(6);
        break;
      case ShoppingTypeEnum.shopping:
        writer.writeByte(7);
        break;
      case ShoppingTypeEnum.charity:
        writer.writeByte(8);
        break;
      case ShoppingTypeEnum.pets:
        writer.writeByte(9);
        break;
      case ShoppingTypeEnum.socialLife:
        writer.writeByte(10);
        break;
      case ShoppingTypeEnum.phone:
        writer.writeByte(11);
        break;
      case ShoppingTypeEnum.fun:
        writer.writeByte(12);
        break;
      case ShoppingTypeEnum.gifts:
        writer.writeByte(13);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
