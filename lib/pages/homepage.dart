// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/bill.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/lists/billlist.dart';
import 'package:splitbill/pages/settingspage.dart';
import 'package:splitbill/pages/storelistpage.dart';
import 'package:splitbill/pages/viewbillpage.dart';

import '../classes/store.dart';

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
            icon: const Icon(Icons.abc),
            onPressed: () {
              addTemp();
            },
          ),
          IconButton(
            icon: const Icon(Icons.alarm),
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
              print('printing');
              return InkWell(
                onTap: () async {
                  await Hive.openBox<Bill>('Bill');
                  print("Pushing $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "ViewBillPage"),
                      builder: (context) => ViewBillPage(storeIndex: index),
                    ),
                  );
                },
                child: BillList(
                    box.getAt(index)!.storeName,
                    box.getAt(index)?.billDesc,
                    box.getAt(index)!.price.toString(),
                    box.getAt(index)!.priceCurrency,
                    box.getAt(index)!.userPaying,
                    box.getAt(index)!.finished),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Hive.openBox<Store>('Store');
          Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "StoreListPage"),
                builder: (context) => const StoreListPage(),
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
    final box = Hive.box<Bill>('Bill');
    // Bill temp = Bill(
    //   storeName: "Count ${box.length}",
    //   billDesc: "Desc ${box.length}",
    //   boughtItems: [
    //     // Item(itemName: "A", itemDesc: "", itemCurrency: "", itemPrice: Random().nextInt(10000))
    //   ],
    //   dateTime: DateTime.now().toString(),
    //   price: Random().nextInt(10000),
    //   // priceCurrency: "NTD",
    //   userPaying: Contact(contactName: "Xevenst"),
    //   finished: Random().nextInt(10000)%2==0?false:true,
    // );
    // await box.put(box.length, temp);
  }

  resetTemp() async {
    final box = Hive.box<Bill>('Bill');
    if (box.length != 0) {
      await Hive.box<Bill>('Bill').clear();
    }
  }
}
