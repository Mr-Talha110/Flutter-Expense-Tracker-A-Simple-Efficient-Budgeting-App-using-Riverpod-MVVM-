// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_track_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseTransactionModelAdapter
    extends TypeAdapter<ExpenseTransactionModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseTransactionModel(
      shoppingType: fields[0] as ShoppingTypeEnum,
      amount: fields[1] as double,
      note: fields[2] as String,
      date: fields[3] as DateTime,
      txId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseTransactionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.shoppingType)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.txId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
