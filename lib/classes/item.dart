import 'package:currency_picker/currency_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'item.g.dart';

@HiveType(typeId: 2)
class Item{
  @HiveField(0)
  late String itemName;
  @HiveField(1)
  late String? itemDesc;
  @HiveField(2)
  late num itemPrice;
  @HiveField(3)
  late Currency itemCurrency;

  Item({required this.itemName,this.itemDesc,required this.itemPrice,required this.itemCurrency});
}