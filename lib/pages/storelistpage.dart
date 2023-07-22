// ignore_for_file: use_build_context_synchronously

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/lists/storelist.dart';
import 'package:splitbill/pages/contactslistpage.dart';

import '../classes/contact.dart';
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
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Hive.openBox<Store>('Store');
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: "AddStorePage"),
              builder: (context) => AddStorePage(editMode: false,),
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
                onTap: () async {
                  await Hive.openBox<Contact>('Contact');
                  await Hive.openBox<Store>('Store');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "ContactListPage"),
                      builder: (context) => ContactsListPage(store: storeBox.getAt(index),),
                    ),
                  );
                },
                child: StoreList(
                    context,
                    box.getAt(index)!.storeName,
                    box.getAt(index)?.storeDesc,
                    box.getAt(index)?.storeOpenTime,
                    box.getAt(index)?.storeItems,
                    box.getAt(index)!.storeCurrency,
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
}
