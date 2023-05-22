import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/item.dart';

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
            Item newItem = Item(itemName: nameController.text,itemDesc: nameController.text,itemPrice: double.parse(priceController.text));
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
          ],
        ),
      ),
    );
  }
}
