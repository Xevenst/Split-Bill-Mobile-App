import 'package:flutter/material.dart';
import 'package:splitbill/pages/selectitempage.dart';

// ignore: non_constant_identifier_names
Widget ItemCard(ItemSelected itemSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(itemSelected.item.itemName),Text('Quantity: ${itemSelected.quantity}')]),
      ));
}
