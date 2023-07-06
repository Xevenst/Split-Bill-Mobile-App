// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

Widget ItemListEdit(
    String name, String? description, num itemPrice) {
  return Column(
    children: [
      ListTile(
        //TODO: In the future change to card to provide better image as well
        title: Text(name),
        subtitle: Text(description ?? "No description"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                itemPrice.toString().replaceAll(RegExp(r'.0'), '')),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      const Divider(thickness: 2, height: 5),
    ],
  );
}
