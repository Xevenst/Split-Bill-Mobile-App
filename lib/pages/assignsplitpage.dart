import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../classes/contact.dart';
import '../classes/item.dart';
import '../classes/store.dart';

class AssignSplitPage extends StatefulWidget {
  const AssignSplitPage(
      {super.key,
      required this.storeIndex,
      required this.contactIndex,
      required this.itemList});
  final int storeIndex;
  final List<int> contactIndex;
  final List<Item> itemList;

  @override
  State<AssignSplitPage> createState() => _AssignSplitPageState();
}

class _AssignSplitPageState extends State<AssignSplitPage> {
  late Box contactBox;
  late Box storeBox;

  @override
  void initState() {
    contactBox = Hive.box<Contact>('Contact');
    storeBox = Hive.box<Store>('Store');
    // items =
    super.initState();
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Assign Split'),
        actions: const [],
      ),
      body: Column(
        children: [
          Text(
            storeBox.getAt(widget.storeIndex)!.storeName.toString(),
            textAlign: TextAlign.center,
          ),
          ListView.builder(
            itemCount: widget.itemList.length,
            itemBuilder: (context, index) {
              
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          setState(() {});
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
