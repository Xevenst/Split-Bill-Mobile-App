// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:splitbill/pages/selectitempage.dart';

import '../classes/item.dart';

Widget ItemList(Item item, bool inItemSelect, StateSetter setState, ValueNotifier<List<int>> count, String storeCurrency, ValueNotifier<num> totalprice,
    int index,ValueNotifier<List<ItemSelected>> selectedItem, ValueNotifier<bool> selected) {
  return Column(
    children: [
      ListTile(
        tileColor: inItemSelect ? Colors.blue[100] : Colors.white,
        //TODO: In the future change to card to provide better image as well
        title: Text(item.itemName),
        subtitle: Text(item.itemDesc ?? "No description"),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            onPressed: () {
              setState(() {
                print("Reduce");
                if (count.value[index] > 0) {
                  selectedItem.value[selectedItem.value.indexWhere((e) => e.item == item)].quantity -= 1;
                  if (count.value[index] == 1) {
                    selectedItem.value.remove(selectedItem.value[selectedItem.value.indexWhere((e) => e.item == item)]);
                    if(selectedItem.value.isEmpty){
                      selected.value = false;
                    }
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
          Text(
              "$storeCurrency ${item.itemPrice.toString().replaceAll(RegExp(r'.0'), '')} x ${count.value[index]} items"),
          IconButton(
            onPressed: () {
              setState(() {
                print("Add");
                selected.value = true;
                if (count.value[index] == 0) {
                  selectedItem.value.add(ItemSelected(item: item, quantity: 0));
                }
                count.value[index] += 1;
                selectedItem.value[selectedItem.value.indexWhere((e) => e.item == item)].quantity +=1;
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
