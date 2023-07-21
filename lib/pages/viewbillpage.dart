import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../classes/bill.dart';
import '../classes/store.dart';
import '../lists/viewbill.dart';

// ignore: must_be_immutable
class ViewBillPage extends StatefulWidget {
  ViewBillPage({super.key, required this.storeIndex});
  int storeIndex;

  @override
  State<ViewBillPage> createState() => _ViewBillPageState();
}

class _ViewBillPageState extends State<ViewBillPage> {
  late Box storeBox;
  late Bill bill;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeBox = Hive.box<Bill>('Bill');
    bill = storeBox.getAt(widget.storeIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Bill'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            //STORE NAME
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                bill.storeName,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Created at: ${bill.dateTime.substring(
                  0,
                )}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: bill.boughtItems.length,
                itemBuilder: (context, index) {
                  return ViewBill(context, bill.boughtItems[index]);
                },
              ),
            ),
          ),
          Visibility(
            visible: !bill.finished,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () async {
                    bill.finished = true;
                    Bill temp = bill;
                    await storeBox.put(bill.dateTime,temp);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 50)),
                  child: const Text('Settle Bill')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(25),
        height: 80.0,
        color: Colors.grey[300],
        child: Center(
          child: Text(
            'Total price: ${storeBox.getAt(widget.storeIndex).price}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
