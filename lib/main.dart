import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splitbill/classes/bill.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/classes/item.dart';
import 'package:splitbill/classes/store.dart';
import 'package:splitbill/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  print(dir.path);
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(StoreAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Bill>('Bill');
  await Hive.openBox<Store>("Store");
  await Hive.openBox<Item>("Item");
  await Hive.openBox<Contact>("Contact");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
