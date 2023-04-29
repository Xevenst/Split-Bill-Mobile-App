import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'package:splitbill/classes/bill.dart'; //TODO: Remove as this is debug
import 'package:splitbill/classes/item.dart'; //TODO: Remove as this is debug
import 'package:path_provider/path_provider.dart';
import 'package:splitbill/pages/addbillpage.dart';
import 'package:splitbill/lists/billlist.dart';
import 'package:splitbill/pages/settingspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count=0;
  late Box billBox;
  
  @override
  void initState() {
    super.initState();
    billBox = Hive.box<Bill>('Bill');
  }

  @override
  void dispose() {
    super.dispose();
    billBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill List'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ((context) => const SettingsPage())));},
          ),
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: (){addTemp();},
          ),
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: (){resetTemp();},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: billBox.length,
        itemBuilder:(context, index) {
          return BillList(billBox.get(count)?.storeName,billBox.get(count)?.billDesc,billBox.get(count)?.price.toString(),billBox.get(count)?.priceCurrency,billBox.get(count)?.finished);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(settings: const RouteSettings(name: "AddBillPage"), builder: (context) => AddBillPage(),)).then(onPop);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  onPop(dynamic value)
  {
    setState(() {
      
    });
  }
  addTemp()async{ //TODO: Remove as this is debug
    final box = await Hive.openBox<Bill>('Bill');
    print(box.length);
    await box.put(count,Bill(storeName: "Mamakkau $count",billDesc: "Desc $count",boughtItems: [Item(itemName: "A",itemDesc: "",itemCurrency: "NTD",itemPrice: 100)],dateTime: DateTime.now().toString(),price: 100,priceCurrency: "NTD"));
    print("element added ${billBox.get(count)!.storeName}");
    count++;
    print(box.length);
    setState(() {
      
    });
  }
  resetTemp()async{ //TODO: Remove as this is debug
    if(count!=0){
      print("COUNT NOT 0");
      Hive.box<Bill>('Bill').clear();
      print("elements deleted");
      count=0;
      setState(() {
        
      });
    }
  }
}