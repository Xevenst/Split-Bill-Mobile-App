// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/lists/itemlist.dart';

import '../classes/item.dart';
import 'additempage.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  late List<Item> itemList = [];
  late Box storeBox;
  late Currency currencySelected;

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

  @override
  Widget build(BuildContext context) {
    final TextEditingController curController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add New Store'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            storeBox = await Hive.openBox<Store>('Store');
            formKey.currentState?.save();
            Store newStore = Store(
                storeName: storeController.text,
                storeDesc: desController.text,
                storeItems: itemList,
                storeCurrency: currencySelected,
            );
            storeBox.put(storeController.text, newStore);
            Navigator.pop(context);
            setState(() {});
          }
        },
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: storeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Store Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name should not be empty!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: desController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
              ),
              Center(
                // padding: const EdgeInsets.all(5),
                child: Text(itemList.isEmpty
                    ? 'Item list is empty, add item by using the plus button below'
                    : itemList.length > 1
                        ? 'Items:'
                        : 'Item:'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return ItemList(
                      itemList[index].itemName,
                      itemList[index].itemDesc,
                      itemList[index].itemPrice,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: curController,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Currency",
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[]")),
                  ],
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        curController.text = currency.symbol;
                        currencySelected = currency;
                      },
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please choose a currency!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              //TODO: Add field for store open and close day and time
              Padding(
                padding: const EdgeInsets.all(20),
                child: IconButton(
                  onPressed: () async {
                    Item? newItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: RouteSettings(name: "AddItemPage"),
                        builder: (context) => const AddItemPage(),
                      ),
                    );
                    setState(() {
                      if (newItem != null) {
                        itemList.add(newItem);
                      }
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
