import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../classes/item.dart';
import '../classes/store.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController curController = TextEditingController();

  late Currency currencySelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formKey.currentState!.validate()){
            formKey.currentState?.save();
            //TODO: Save to list on previous page (addstorepage/additempage)
            Item newItem = Item(itemName: nameController.text,itemDesc: nameController.text,itemPrice: double.parse(priceController.text),itemCurrency: currencySelected);
            Navigator.pop(context,newItem);
          }
        },
        child: const Icon(Icons.check),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Item Name",
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Item Description (optional)",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Item Price",
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter price!";
                  } else {
                    return null;
                  }
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
          ],
        ),
      ),
    );
  }
}
