// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 3;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      contactName: fields[0] as String,
      contactDesc: fields[1] as String?,
      contactImage: fields[2] as String?,
      contactDebt: fields[3] == null ? 0 : fields[3] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contactName)
      ..writeByte(1)
      ..write(obj.contactDesc)
      ..writeByte(2)
      ..write(obj.contactImage)
      ..writeByte(3)
      ..write(obj.contactDebt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
