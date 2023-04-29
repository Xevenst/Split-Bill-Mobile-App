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

  Store({required this.storeName, this.storeDesc, this.storeOpenTime,this.storeItems});
}