import 'package:currency_picker/currency_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/item.dart';

part 'store.g.dart';

@HiveType(typeId: 1)
class Store{
  @HiveField(0)
  late String storeName;
  @HiveField(1)
  late String? storeDesc;
  @HiveField(2)
  late String? storeOpenTime;
  @HiveField(3)
  late List<Item>? storeItems;
  @HiveField(4)
  late Currency storeCurrency;

  Store({required this.storeName, this.storeDesc, this.storeOpenTime,this.storeItems,required this.storeCurrency});
}