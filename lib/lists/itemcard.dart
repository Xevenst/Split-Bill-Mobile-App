import 'package:flutter/material.dart';

import '../classes/item.dart';

// ignore: non_constant_identifier_names
Widget ItemCard(Item item, int count) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(item.itemName),Text('Quantity: $count')]),
      ));
}
