import 'package:flutter/material.dart';

import '../classes/item.dart';

// ignore: non_constant_identifier_names
Widget ItemCard(Item item) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
    child:Card(
      margin: const EdgeInsets.all(10),
      color: Colors.blue[100],
      shadowColor: Colors.blueGrey,
      child: Text(item.itemName),
    ));
}
