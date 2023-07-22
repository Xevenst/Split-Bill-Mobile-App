// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/store.dart';

import '../classes/item.dart';
import '../lists/itemlist.dart';
import 'additempage.dart';

class AddStorePage extends StatefulWidget {
  AddStorePage({super.key,required this.editMode,this.boxName,this.boxCurrency});
  bool editMode;
  String? boxName;
  String? boxCurrency;

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController curController = TextEditingController();
  late List<Item> itemList = [];
  late Box storeBox;
  late String currencySelected;
  
  @override
  void initState() {
    super.initState();
    storeBox = Hive.box<Store>('Store');
    if(widget.editMode==true){
      storeController.text = widget.boxName!;
      curController.text = widget.boxCurrency!;
      currencySelected = widget.boxCurrency!;
      itemList = storeBox.get(widget.boxName).storeItems;
    }
    print(itemList.length);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () async {
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
            print(newStore.storeItems?.length);
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
              //STORE NAME
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: storeController,
                  readOnly: widget.editMode,
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
              //STORE DESCRIPTION
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
              //CURRENCY
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: curController,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Currency",
                  ),
                  readOnly: true,
                  enabled: !widget.editMode,
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        curController.text = currency.symbol;
                        currencySelected = currency.name;
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
              Center(//ITEMS
                // padding: const EdgeInsets.all(5),
                child: Text(itemList.isEmpty
                    ? 'Item list is empty, add item by using the plus button above'
                    : itemList.length > 1
                        ? 'Items:'
                        : 'Item:'),
              ),
              Padding(
                padding: itemList.isNotEmpty?const EdgeInsets.all(20):const EdgeInsets.all(0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return ItemListEdit(
                      itemList[index].itemName,
                      itemList[index].itemDesc,
                      itemList[index].itemPrice,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
