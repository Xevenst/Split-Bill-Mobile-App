// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 0;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      storeName: fields[0] == null ? '' : fields[0] as String,
      billDesc: fields[1] == null ? '' : fields[1] as String?,
      boughtItems: (fields[2] as List).cast<Item>(),
      dateTime: fields[3] as String,
      price: fields[4] as num,
      priceCurrency: fields[5] as Currency,
      userPaying: fields[6] as Contact,
      finished: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.storeName)
      ..writeByte(1)
      ..write(obj.billDesc)
      ..writeByte(2)
      ..write(obj.boughtItems)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.priceCurrency)
      ..writeByte(6)
      ..write(obj.userPaying)
      ..writeByte(7)
      ..write(obj.finished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}