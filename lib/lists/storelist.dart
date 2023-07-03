// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/item.dart';
import 'package:splitbill/pages/addstorepage.dart';
import 'package:splitbill/pages/viewstorepage.dart';

import '../classes/store.dart';

Widget StoreList(
    BuildContext context,
    String storeName,
    String? storeDesc,
    String? storeOpenTime,
    List<Item>? storeItems,
    String storeCurrency,
    Box box,
    StateSetter setState) {
  //TODO: CHANGE ALL STRING WITH BOX . GETSTRING
  return Column(
    children: [
      ListTile(
          leading: CircleAvatar(child: Text(storeName[0])),
          title: Text(storeName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(storeDesc ?? "No description"),
              Text(storeOpenTime ?? "Unknown open-close time"),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  await Hive.openBox<Store>('Store');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "ViewStorePage"),
                      builder: ((context) => const ViewStorePage()),
                    ),
                  );
                },
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () async {
                  await Hive.openBox<Store>('Store');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "AddStorePage"),
                      builder: ((context) => AddStorePage(editMode: true,boxName: storeName,boxCurrency: storeCurrency)),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  box = await Hive.openBox<Store>('Store');
                  box.delete(storeName);
                  setState(() {});
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )),
      const Divider(
        color: Colors.black38,
        thickness: 2,
        height: 5,
      )
    ],
  );
}
