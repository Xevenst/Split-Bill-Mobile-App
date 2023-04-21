import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:splitbill/pages/restaurantlistpage.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({super.key});

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // tooltip: 'Go back',
          color:Colors.white,
          onPressed: (){Navigator.pop(context);},
        ),
        
        centerTitle: false,
        title: const Text('Add new bill data'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if(checkValid())
          {
            //TODO: Put to hive box
          }
          else
          {
            //TODO: Put red fields on invalid/ empty input
          }
        },
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Restaurant Name",
                suffixIcon: IconButton(
                  icon: Icon(Icons.contacts),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => RestaurantListPage()));
                  },
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  bool checkValid(){
    return true;
  }
}