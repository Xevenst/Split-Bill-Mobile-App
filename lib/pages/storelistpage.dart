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
  late Box storeBox;

  @override
  void initState() {
    super.initState();
    storeBox = Hive.box<Store>('Store');
  }

  @override
  void dispose() {
    super.dispose();
    storeBox.close();
  }
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
        actions: [
          IconButton(
            onPressed: () {
              addContact();
            },
            icon: Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              resetContact();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Store>('Store').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, index);
                },
                child: StoreList(
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  addContact() async {
    final storeBox = Hive.box<Store>('Store');
    Store temp = Store(
      storeName: "Xevenst ${storeBox.length}",
    );
    await storeBox.put(storeBox.length, temp);
    print("Element added");
  }

  resetContact() async {
    final storeBox = Hive.box<Store>('Store');
    if (storeBox.length != 0) {
      await Hive.box<Store>('Store').clear();
    }
  }
}
