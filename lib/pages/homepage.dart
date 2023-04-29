import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/bill.dart'; //TODO: Remove as this is debug
import 'package:splitbill/classes/item.dart'; //TODO: Remove as this is debug
import 'package:path_provider/path_provider.dart';
import 'package:splitbill/pages/addbillpage.dart';
import 'package:splitbill/lists/billlist.dart';
import 'package:splitbill/pages/settingspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box billBox;

  @override
  void initState() {
    super.initState();
    billBox = Hive.box<Bill>('Bill');
  }

  @override
  void dispose() {
    super.dispose();
    billBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill List'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const SettingsPage()),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: () {
              addTemp();
            },
          ),
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () {
              resetTemp();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Bill>('Bill').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              // return null;
              return BillList(
                  box.get(index)!.storeName,
                  box.get(index)?.billDesc,
                  box.get(index)!.price.toString(),
                  box.get(index)!.priceCurrency,
                  box.get(index)!.finished);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddBillPage"),
                builder: (context) => AddBillPage(),
              )).then(onPop);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  onPop(dynamic value) {
    setState(() {});
  }

  addTemp() async {
    //TODO: Remove as this is debug
    final box = Hive.box<Bill>('Bill');
    Bill temp = Bill(
      storeName: "Count ${box.length}",
      billDesc: "Desc ${box.length}",
      boughtItems: [
        Item(itemName: "A", itemDesc: "", itemCurrency: "NTD", itemPrice: 100)
      ],
      dateTime: DateTime.now().toString(),
      price: 100,
      priceCurrency: "NTD",
    );
    await box.put(box.length, temp);
    // print("element added ${await box.get(index).storeName}");
  }

  resetTemp() async {
    final box = Hive.box<Bill>('Bill');
    //TODO: Remove as this is debug
    if (box.length!=0) {
      print("COUNT NOT 0");
      await Hive.box<Bill>('Bill').clear();
      print("element deleted");
    } else {
      print("No elements to be deleted");
    }
  }
}
