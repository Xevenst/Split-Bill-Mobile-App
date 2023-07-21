// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/lists/contactlist.dart';
import 'package:splitbill/pages/selectitempage.dart';

import '../classes/store.dart';
import 'addcontactpage.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key, required this.store});
  final Store store;
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

  bool isContactSelected = false;
  bool isSearchSelected = false;
  late int selectCounter = 0;
  late List<Contact> selectedContact = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: !isSearchSelected,
          child: const Text('Choose contact'),
        ),
        leading: IconButton(
          icon: !isContactSelected
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.cancel),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () {
            if (isContactSelected == false) {
              Navigator.of(context).pop();
            } else {
              isContactSelected = false;
              selectedContact.clear();
              selectCounter = selectedContact.length;
            }
            setState(() {});
          },
        ),
        actions: [
          Visibility(
            visible: !isSearchSelected,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                isSearchSelected = true;
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
        child: isContactSelected == false
            ? const Icon(Icons.add)
            : const Icon(Icons.check),
        onPressed: () async {
          if (isContactSelected == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddContactPage"),
                builder: (context) => AddContactPage(),
              ),
            );
            setState(() {});
            await Hive.openBox<Contact>('Contact');
          } else {
            await Hive.openBox<Store>('Store');
            await Hive.openBox<Contact>('Contact');
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "SelectItemPage"),
                builder: (context) => SelectItemPage(
                  store: widget.store,
                  contact: selectedContact,
                ), //TODO: CHANGE INDEX TO BOX NAMES TO AVOID OVERWRITING
              ),
            );
          }
          isContactSelected = false;
          isSearchSelected = false;
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
                  if (selectedContact
                      .any((element) => element == contactBox.getAt(index))) {
                    selectedContact.remove(contactBox.getAt(index));
                  } else {
                    selectedContact.add(contactBox.getAt(index));
                    selectedContact
                        .sort((a, b) => a.contactName.compareTo(b.contactName));
                  }
                  selectCounter = selectedContact.length;
                  setState(() {
                    if (selectCounter > 0) {
                      isContactSelected = true;
                    } else {
                      isContactSelected = false;
                    }
                  });
                },
                child: ContactList(
                    context,
                    contactBox.getAt(index)!.contactName,
                    selectedContact
                        .any((element) => element == contactBox.getAt(index)),
                    contactBox,
                    setState,
                    index,
                    isContactSelected,
                    selectedContact,
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
      isContactSelected = false;
    });
  }

  void resetContact() async {
    final box = Hive.box<Contact>('Contact');
    if (box.length != 0) {
      await Hive.box<Contact>('Contact').clear();
    }
    setState(() {
      isContactSelected = false;
    });
  }
}
