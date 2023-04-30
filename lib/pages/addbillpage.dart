// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/pages/contactslistpage.dart';
import 'package:splitbill/pages/storelistpage.dart';

class AddBillPage extends StatefulWidget {
  AddBillPage({super.key});

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  AddBillPage get widget => super.widget;
  Widget build(BuildContext context) {
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
        title: const Text('Add new bill data'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right_alt),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactsList(),
              ),
            );
          }
        },
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: storeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Store Name",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.contacts),
                    onPressed: () async {
                      await Hive.openBox<Store>('Store');
                      final box = Hive.box<Store>('Store');
                      int? newValue = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          settings: RouteSettings(name: "ContactsListPage"),
                          builder: (context) => StoreListPage(),
                        ),
                      );
                      if (newValue != null) {
                        setState(
                          () {
                            storeController.text = box.get(newValue)!.storeName;
                            nameController.text = box.get(newValue)!.storeName;
                          },
                        );
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter correct data";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter correct data";
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
