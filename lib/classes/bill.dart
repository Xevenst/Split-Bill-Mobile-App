import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/pages/assignsplitpage.dart';

// import 'itemassign.g.dart';
part 'bill.g.dart';

@HiveType(typeId: 0)
class Bill extends HiveObject{
  @HiveField(0,defaultValue:"")
  late String storeName;
  @HiveField(1,defaultValue: "")
  late String? billDesc;
  @HiveField(2)
  late List<ItemAssign> boughtItems;
  @HiveField(3)
  late String dateTime;
  @HiveField(4)
  late num price;
  @HiveField(5)
  late String priceCurrency;
  @HiveField(6)
  late Contact userPaying;
  @HiveField(7,defaultValue: false)
  late bool finished;
  Bill({required this.storeName,this.billDesc,required this.boughtItems,required this.dateTime,required this.price,required this.priceCurrency,required this.userPaying,this.finished=false});
}