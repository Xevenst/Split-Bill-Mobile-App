import 'package:flutter/material.dart';
import 'package:splitbill/classes/item.dart';
Widget StoreList(String storeName, String? storeDesc, String? storeOpenTime, List<Item>? storeItems){
  return Column(
    children: [
      Container(
        child: ListTile(
          leading: CircleAvatar(child: Text(storeName[0])),
          title: Text(storeName),
          subtitle: Text(storeDesc ?? ""),
          trailing: Text(storeOpenTime??"Unknown open-close time"),
          onTap: () {
            
          },
        ),
      ),
      const Divider(color: Colors.black38,thickness: 2,height: 5,)
    ],
  );
}