// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

import '../classes/item.dart';

Widget ItemList(Item item, bool inItemSelect, StateSetter setState, ValueNotifier<List<int>> count,
    List<Item> itemSelected, String storeCurrency, ValueNotifier<num> totalprice,
    int index) {
  return Column(
    children: [
      ListTile(
        tileColor: inItemSelect ? Colors.blue[100] : Colors.white,
        //TODO: In the future change to card to provide better image as well
        title: Text(item.itemName),
        subtitle: Text(item.itemDesc ?? "No description"),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
              "$storeCurrency ${item.itemPrice.toString().replaceAll(RegExp(r'.0'), '')} x ${count.value[index]}"),
          IconButton(
            onPressed: () {
              setState(() {
                print("Reduce");
                if (count.value[index] > 0) {
                  if (count.value[index] == 1) {
                    itemSelected.remove(item);
                  }
                  count.value[index] -= 1;
                  totalprice.value -= item.itemPrice;
                }
              });
              print("Count: ${count.value[index]}");
              print("Total price: ${totalprice.value}");
            },
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                print("Add");
                if (count.value[index] == 0) {
                  itemSelected.add(item);
                }
                count.value[index] += 1;
                totalprice.value += item.itemPrice;
              });
              print("Count: ${count.value[index]}");
              print("Total price: ${totalprice.value}");
            },
            icon: const Icon(Icons.add),
          ),
        ]),
      ),
      const Divider(thickness: 2, height: 5),
    ],
  );
}
