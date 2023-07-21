// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../classes/contact.dart';

Column ContactList(
    BuildContext context,
    String contactName,
    bool selected,
    Box box,
    StateSetter setState,
    int index,
    bool contactSelected,
    List<Contact> contactSelectedIndex,
    int selectCounter) {
  return Column(
    children: [
      Container(
        child: ListTile(
          leading: CircleAvatar(
            child: selected == true
                ? const Icon(Icons.check)
                : Text(contactName[0]),
          ),
          title: Text(contactName),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  await box.delete(contactName);
                  setState(() {
                    contactSelectedIndex.clear();
                    selectCounter = contactSelectedIndex.length;
                    contactSelected = false;
                    print(selectCounter);
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
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

Widget Contacts(Contact contact) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(contact.contactName[0]),
            ),
            Text(contact.contactName),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}
