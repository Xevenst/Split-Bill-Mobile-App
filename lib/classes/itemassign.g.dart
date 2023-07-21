import 'package:hive_flutter/adapters.dart';

import '../pages/assignsplitpage.dart';
import 'contact.dart';
import 'item.dart';

class ItemAssignAdapter extends TypeAdapter<ItemAssign> {
  @override
  final typeId = 5;

  @override
  ItemAssign read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemAssign(
        item: fields[0] as Item,
        contact: (fields[1] as List).cast<Contact>(),
        quantity: fields[2] as int,
        totalItemPrice: fields[3] as num);
  }

  @override
  void write(BinaryWriter writer, ItemAssign obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.contact)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.totalItemPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAssignAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
