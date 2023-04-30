import 'package:hive_flutter/hive_flutter.dart';
part 'contact.g.dart';

@HiveType(typeId: 3)
class Contact{
  @HiveField(0)
  late String contactName;
  @HiveField(1)
  late String? contactImage;
  @HiveField(2,defaultValue: 0)
  late num? contactDebt;

  Contact({required this.contactName,this.contactImage,this.contactDebt=0});
}