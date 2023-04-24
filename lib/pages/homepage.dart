import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:splitbill/pages/addbillpage.dart';
import 'package:splitbill/pages/settingspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill List'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ((context) => const SettingsPage())));},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder:(context, index) {
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(settings: RouteSettings(name: "AddBillPage"), builder: (context) => AddBillPage(),)).then(onPop);
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
}