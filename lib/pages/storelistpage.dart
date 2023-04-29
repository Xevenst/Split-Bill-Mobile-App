import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/item.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/lists/storelist.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  late Box storeBox = Hive.box<Store>('Store');
  bool searchSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Visibility(
            visible: !searchSelected,
            child: const Text('Store List'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop({"hello", "hi"});
            },
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Store>('Store').listenable(),
          builder: (context, box, child) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return StoreList(
                  "Wok",
                  "Wok Noodle",
                  "00.00 - 14.00",
                  [
                    Item(
                        itemName: "Item",
                        itemDesc: "ItemDesc",
                        itemPrice: 10,
                        itemCurrency: "NTD")
                  ],
                );
              },
            );
          },
        ));
  }
}
