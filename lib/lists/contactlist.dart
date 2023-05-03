import 'package:flutter/material.dart';

Widget ContactList(String contactName) {
  return Column(
    children: [
      Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(contactName[0]),
          ),
          title: Text(contactName),
        ),
      ),
      const Divider(
        color: Colors.black38,
        thickness: 2,
        height: 5,
      ),
    ],
  );
}
