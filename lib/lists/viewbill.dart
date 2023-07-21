import 'package:flutter/material.dart';

import '../pages/assignsplitpage.dart';

// ignore: non_constant_identifier_names
Widget ViewBill(BuildContext context, ItemAssign itemAssign) {
  return ListTile(
    title: Text('Item name: ${itemAssign.item.itemName}', style: const TextStyle(fontSize: 20)),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Who bought this:'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: itemAssign.contact.length,
          itemBuilder: (context, index) {
            return Text('- ${itemAssign.contact[index].contactName}');
          },
        ),
        const Divider(thickness: 2),
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${itemAssign.quantity} x ${itemAssign.item.itemPrice} = ${itemAssign.totalItemPrice}'),
      ],
    ),
  );
}
