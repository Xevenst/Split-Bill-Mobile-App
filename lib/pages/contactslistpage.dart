// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/lists/contactlist.dart';
import 'package:splitbill/pages/selectitempage.dart';

import '../classes/store.dart';
import 'addcontactpage.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key, required this.storeIndex});
  final int storeIndex;
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  late Box contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<Contact>('Contact');
  }
  
  bool contactSelected = false;
  bool searchSelected = false;
  late int selectCounter = 0;
  late List<int> contactSelectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: !searchSelected,
          child: const Text('Choose contact'),
        ),
        leading: IconButton(
          icon: !contactSelected
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.cancel),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () {
            if (contactSelected == false) {
              Navigator.of(context).pop();
            } else {
              contactSelected = false;
              contactSelectedIndex.clear();
              selectCounter = contactSelectedIndex.length;
            }
            setState(() {});
          },
        ),
        actions: [
          Visibility(
            visible: !searchSelected,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                searchSelected = true;
                setState(() {});
              },
            ),
          ),
          IconButton(
            onPressed: () {
              addContact();
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              resetContact();
            },
            icon: const Icon(Icons.restore),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        child: contactSelected == false
            ? const Icon(Icons.add)
            : const Icon(Icons.check),
        onPressed: () async {
          if (contactSelected == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddContactPage"),
                builder: (context) => AddContactPage(),
              ),
            );
            await Hive.openBox<Contact>('Contact');
          } else {
            await Hive.openBox<Store>('Store');
            await Hive.openBox<Contact>('Contact');
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "SelectItemPage"),
                builder: (context) => SelectItemPage(
                  storeIndex: widget.storeIndex,
                  contactIndex: contactSelectedIndex,
                ), //TODO: CHANGE INDEX TO BOX AMES TO AVOID OVERWRITIN G
              ),
            );
          }
          contactSelected = false;
          searchSelected = false;
          setState(() {});
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Contact>('Contact').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (contactSelectedIndex.any((element) => element == index)) {
                    contactSelectedIndex.remove(index);
                  } else {
                    contactSelectedIndex.add(index);
                    contactSelectedIndex.sort();
                  }
                  selectCounter = contactSelectedIndex.length;
                  setState(() {
                    if (selectCounter > 0) {
                      contactSelected = true;
                    } else {
                      contactSelected = false;
                    }
                  });
                },
                child: ContactList(
                    context,
                    contactBox.getAt(index)!.contactName,
                    contactSelectedIndex.any((element) => element == index),
                    contactBox,
                    setState,
                    index,
                    contactSelected,
                    contactSelectedIndex,
                    selectCounter),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(25),
        height: 80.0,
        color: Colors.grey[500],
        child: Text(
            selectCounter > 1
                ? '$selectCounter contacts selected'
                : '$selectCounter contact selected',
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  void addContact() async {
    final box = Hive.box<Contact>('Contact');
    print(contactBox.length);
    Contact temp = Contact(contactName: "Xevenst ${box.length}");
    await box.put(temp.contactName, temp);
    setState(() {
      contactSelected = false;
    });
  }

  void resetContact() async {
    final box = Hive.box<Contact>('Contact');
    if (box.length != 0) {
      await Hive.box<Contact>('Contact').clear();
    }
    setState(() {
      contactSelected = false;
    });
  }
}
