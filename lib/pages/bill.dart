// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget Bill(String? nameTitle){
  return Column(
    children: [
      Container(
        alignment: Alignment.center,
        child: ListTile(
          leading: CircleAvatar(child: Text("A+"),),//TODO: Change with name or whatever
          title: Text(nameTitle!, style: TextStyle(fontSize: 16),),
          subtitle: Text("Best store ever",style: TextStyle(fontSize: 12),),
          trailing: Text("Not yet paid",style: TextStyle(fontSize: 14,color: Colors.red.shade500),),
          onTap: () {
            
          },
        ),
      ),
      Divider(color: Colors.black38,thickness: 1,height: 5,)
    ],
  );
}