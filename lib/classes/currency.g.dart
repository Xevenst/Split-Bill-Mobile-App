import 'package:currency_picker/currency_picker.dart';
import 'package:hive_flutter/adapters.dart';

class CurrencyAdapter extends TypeAdapter<Currency> {
  @override
  final typeId = 4;

  @override
  Currency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Currency(
        code: fields[0] as String,
        name: fields[1] as String,
        symbol: fields[2] as String,
        flag: fields[3] as String,
        number: fields[4] as int,
        decimalDigits: fields[5] as int,
        namePlural: fields[6] as String,
        symbolOnLeft: fields[7] as bool,
        decimalSeparator: fields[8] as String,
        thousandsSeparator: fields[9] as String,
        spaceBetweenAmountAndSymbol: fields[10] as bool);
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.flag)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.decimalDigits)
      ..writeByte(6)
      ..write(obj.namePlural)
      ..writeByte(7)
      ..write(obj.symbolOnLeft)
      ..writeByte(8)
      ..write(obj.decimalSeparator)
      ..writeByte(9)
      ..write(obj.thousandsSeparator)
      ..writeByte(10)
      ..write(obj.spaceBetweenAmountAndSymbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
