// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/lists/storelist.dart';
import 'package:splitbill/pages/contactslistpage.dart';

import 'addstorepage.dart';

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

  Currency? currencyTempDebug;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); //
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              addStore();
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              resetStore();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Hive.openBox<Store>('Store');
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: "AddStorePage"),
              builder: (context) => AddStorePage(),
            ),
          ).then(onPop);
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Store>('Store').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: "ContactListPage"),
                      builder: (context) => ContactsListPage(),
                    ),
                  );
                },
                child: StoreList(
                    context,
                    box.getAt(index)!.storeName,
                    box.getAt(index)?.storeDesc,
                    box.getAt(index)?.storeOpenTime,
                    box.getAt(index)?.storeItems,
                    box,
                    setState),
              );
            },
          );
        },
      ),
    );
  }

  void onPop(dynamic value) async {
    await Hive.openBox<Store>('Store');
    setState(() {});
  }

  addStore() async {
    await Hive.openBox<Store>('Store');
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showSearchField: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        print('Select currency: ${currency.name}');

      },
      favorite: ['USD'],
    );
    final storeBox = Hive.box<Store>('Store');
    // Store temp = Store(
    //   storeName: "Xevenst ${storeBox.length}",
    //   storeItems: [],
    // );
    // await storeBox.put("Xevenst ${storeBox.length}", temp);
    setState(() {});
  }

  resetStore() async {
    await Hive.openBox<Store>('Store');
    final storeBox = Hive.box<Store>('Store');
    if (storeBox.length != 0) {
      await Hive.box<Store>('Store').clear();
    }
    setState(() {});
  }
}
