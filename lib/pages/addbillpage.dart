// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:splitbill/pages/contactslistpage.dart';
import 'package:splitbill/pages/restaurantlistpage.dart';

class AddBillPage extends StatefulWidget {
  AddBillPage({super.key});

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController resController = TextEditingController();
  @override
  AddBillPage get widget => super.widget;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // tooltip: 'Go back',
          color:Colors.white,
          onPressed: (){Navigator.pop(context);},
        ),
        title: const Text('Add new bill data'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right_alt),
        onPressed: () {
          if(formKey.currentState!.validate()){
            formKey.currentState?.save();
            Navigator.push(context,MaterialPageRoute(builder: (context) => const ContactsList(),));
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
                controller: resController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Restaurant Name",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.contacts),
                    onPressed: () async {
                      String newValue = await Navigator.push(context,MaterialPageRoute(builder: (context) => RestaurantListPage()));
                      setState(() {
                        resController.text = newValue;
                      });
                    },
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Correct Name";
                  }
                  else{
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Correct Name";
                  }
                  else{
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}