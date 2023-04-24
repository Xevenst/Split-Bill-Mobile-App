// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new contact'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState?.save();
            Navigator.pop(context);
            setState(() {
              
            });
          }
        },
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]")),
                ],
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter name";
                  }
                  else{
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]")),
                ],
                controller: desController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description (Optional)",
                ),
              ),
            ),
          ],
          //TODO: Add Image Picker and Description(?) for customization
        ), 
      ),
    );
  }
}