// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/pages/selectitempage.dart';

import '../classes/item.dart';
import '../pages/assignsplitpage.dart';

Widget ItemList(
    Item item,
    bool inItemSelect,
    StateSetter setState,
    ValueNotifier<List<int>> count,
    String storeCurrency,
    ValueNotifier<num> totalprice,
    int index,
    ValueNotifier<List<ItemSelected>> selectedItem,
    ValueNotifier<bool> selected) {
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
                  selectedItem
                      .value[
                          selectedItem.value.indexWhere((e) => e.item == item)]
                      .reduceQuantity();
                  if (count.value[index] == 1) {
                    selectedItem.value.remove(selectedItem.value[
                        selectedItem.value.indexWhere((e) => e.item == item)]);
                    if (selectedItem.value.isEmpty) {
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
                  selectedItem.value.add(ItemSelected(item: item, quantity: 0,totalItemPrice: 0));
                }
                count.value[index] += 1;
                selectedItem
                    .value[selectedItem.value.indexWhere((e) => e.item == item)]
                    .addQuantity();
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

Widget ItemCard(ItemSelected itemSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(itemSelected.item.itemName),
              Text('Quantity: ${itemSelected.quantity}')
            ]),
      ));
}

Widget ItemListEdit(String name, String? description, num itemPrice) {
  return Column(
    children: [
      ListTile(
        //TODO: In the future change to card to provide better image as well
        title: Text(name),
        subtitle: Text(description ?? "No description"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(itemPrice.toString().replaceAll(RegExp(r'.0'), '')),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      const Divider(thickness: 2, height: 5),
    ],
  );
}

Widget AssignSplitItem(
    ItemAssign itemAssign, List<Contact> contact, StateSetter setState) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(itemAssign.item.itemName),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemAssign.contact.isEmpty?const Text(''):Text('Each person pays: ${itemAssign.totalItemPrice/itemAssign.contact.length}'),
              const SizedBox(width: 200,),
              Text('${itemAssign.quantity} x ${itemAssign.item.itemPrice.toString()} = ${itemAssign.totalItemPrice}'),
            ],
          ),
          subtitle: itemAssign.contact.isEmpty?const Text(''):ListView.builder(
            shrinkWrap: true,
            itemCount: itemAssign.contact.length,
            itemBuilder: (context, index) {
              return Text('- ${itemAssign.contact[index].contactName}');
            },
          ),
        ),
        const Divider(thickness: 2, height: 5),
      ],
    ),
  );
}
