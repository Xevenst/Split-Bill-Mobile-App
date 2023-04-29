// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget BillList(String billName,String? billDesc,String billTotalPrice,String billCurrency, bool billFinished){
  return Column(
    children: [
      Container(
        child: ListTile(
          leading: const CircleAvatar(child: Text("A+"),),//TODO: Change with name or whatever
          title: Text(billName, style: const TextStyle(fontSize: 18),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(billDesc ?? "",style: const TextStyle(fontSize: 14),),
              Text("Created: ${DateFormat('E, d MMM yyyy HH:mm a').format(DateTime.now()).toString()}",style: const TextStyle(fontSize: 12))//TODO: Change this to string as we will take datettime from Billdata
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Price: $billTotalPrice $billCurrency",style: const TextStyle(fontSize: 16)),
              billFinished==true?Text("Finished",style: TextStyle(color:Colors.green.shade400,fontSize: 16)):Text("Not yet finished",style: TextStyle(color:Colors.red.shade400,fontSize: 16)),
            ],
          ),
          onTap: () {
            
          },
        ),
      ),
      const Divider(color: Colors.black38,thickness: 2,height: 5,)
    ],
  );
}