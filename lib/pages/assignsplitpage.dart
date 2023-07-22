// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:splitbill/lists/itemlist.dart';
import 'package:splitbill/pages/selectitempage.dart';

import '../classes/bill.dart';
import '../classes/contact.dart';
import '../classes/item.dart';
import '../classes/store.dart';
import '../lists/contactlist.dart';
import '../classes/itemassign.dart';

class AssignSplitPage extends StatefulWidget {
  const AssignSplitPage({
    super.key,
    required this.store,
    required this.contact,
    required this.itemSelected,
    required this.totalprice,
  });

  final Store store;
  final List<Contact> contact;
  final List<ItemSelected> itemSelected;
  final num totalprice;

  @override
  State<AssignSplitPage> createState() => _AssignSplitPageState();
}

class _AssignSplitPageState extends State<AssignSplitPage> {
  late ValueNotifier<List<ItemAssign>> itemAssign =
      ValueNotifier<List<ItemAssign>>([]);
  late Box storeBox;
  late Box contactBox;
  late Contact tempContactSelect = widget.contact[0];
  late Box billBox;
  List<Item> itemSelected = [];

  @override
  void initState() {
    billBox = Hive.box<Bill>('Bill');
    storeBox = Hive.box<Store>('Store');
    contactBox = Hive.box<Contact>('Contact');
    super.initState();
    for (int i = 0; i < widget.itemSelected.length; i++) {
      //Add the length of itemSelected to itemAssign
      itemAssign.value.add(
        ItemAssign(
          item: widget.itemSelected[i].getItem(),
          contact: [],
          quantity: widget.itemSelected[i].getQuantity(),
          totalItemPrice: widget.itemSelected[i].getTotalItemPrice(),
        ),
      );
      itemSelected.add(widget.itemSelected[i].getItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Splits'),
        actions: [
          Center(
            child: Text(
              'Contact selected now: ${tempContactSelect.contactName}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 30),
          IconButton(
              onPressed: () async {
                bool flag = true;
                for (int i = 0; i < itemAssign.value.length; i++) {
                  if (itemAssign.value[i].contact.isEmpty) {
                    flag = false;
                    break;
                  }
                }
                if (flag) {
                  print(widget.store.storeName);
                  Bill temp = Bill(
                      storeName: widget.store.storeName,
                      boughtItems: itemAssign.value,
                      dateTime: DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()).toString(),
                      price: widget.totalprice,
                      priceCurrency: widget.store.storeCurrency,
                      userPaying: widget.contact[0]);
                  await billBox.put(DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()).toString(), temp);
                Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Every items are not yet distributed')),
                  );
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      //BODY
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.itemSelected.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (itemAssign.value[index].contact.any(((element) =>
                        element.contactName ==
                        tempContactSelect.contactName))) {
                      print("EXISTS, REMOVING");
                      itemAssign.value[index].contact.remove(
                          itemAssign.value[index].contact[itemAssign
                              .value[index].contact
                              .indexWhere((element) =>
                                  element.contactName ==
                                  tempContactSelect.contactName)]);
                      print("Removed, now: ${itemAssign.value[index].contact}");
                    } else {
                      print("DoESN't exists, adding");
                      itemAssign.value[index].contact.add(tempContactSelect);
                      print("Added, now: ${itemAssign.value[index].contact}");
                    }
                    setState(() {});
                  },
                  child: AssignSplitItem(
                      itemAssign.value[index], widget.contact, setState),
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.contact.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    tempContactSelect = widget.contact[index];
                    setState(() {});
                  },
                  child: Contacts(widget.contact[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemAssign {
  Item item;
  List<Contact> contact;
  int quantity;
  num totalItemPrice;
  ItemAssign(
      {required this.item,
      required this.contact,
      required this.quantity,
      required this.totalItemPrice});
}


