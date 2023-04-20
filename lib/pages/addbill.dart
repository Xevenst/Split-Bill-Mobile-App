import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddBill extends StatefulWidget {
  const AddBill({super.key});

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color:Colors.white,
            onPressed: (){Navigator.pop(context);},
          ),
          centerTitle: true,
          title: const Text('Add new bill data'),
        ),
      ),
    );
  }
}