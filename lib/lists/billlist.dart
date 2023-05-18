// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitbill/classes/contact.dart';

Widget BillList(String billName, String? billDesc, String billTotalPrice,
    String billCurrency, Contact billUserPaying, bool billFinished) {//TODO: CHANGE LISTTILE WITH CARD FOR BETTER UI TODO://
  return Column(
    children: [
      Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(billName[0]),
          ), //TODO: Change with name or image provided from user (optional)
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                billName,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Paying: ${billUserPaying.contactName}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                billDesc ?? "",
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "Created: ${DateFormat('E, d MMM yyyy HH:mm a').format(DateTime.now()).toString()}",
                style: const TextStyle(fontSize: 12),
              ), //TODO: Change this to string as we will take datettime from Billdata
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Price: $billTotalPrice $billCurrency",
                  style: const TextStyle(fontSize: 16)),
              billFinished == true
                  ? Text("Finished",
                      style:
                          TextStyle(color: Colors.green.shade400, fontSize: 16))
                  : Text("Not yet finished",
                      style:
                          TextStyle(color: Colors.red.shade400, fontSize: 16)),
            ],
          ),
          onTap: () {},
        ),
      ),
      const Divider(
        color: Colors.black38,
        thickness: 2,
        height: 5,
      )
    ],
  );
}
