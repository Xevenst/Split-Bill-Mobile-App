// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/item.dart';

import '../classes/store.dart';

Widget StoreList(BuildContext context, String storeName, String? storeDesc,
    String? storeOpenTime, List<Item>? storeItems, Box box,StateSetter setState){//TODO: CHANGE ALL STRING WITH BOX . GETSTRING
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
                onPressed: () {},
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  box = await Hive.openBox<Store>('Store');
                  box.delete(storeName);
                  setState((){});
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
