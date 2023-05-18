import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/lists/contactlist.dart';
import 'package:splitbill/pages/assignsplitpage.dart';

import 'addcontactpage.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late Box contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<Contact>('Contact');
  }

  @override
  void dispose() {
    super.dispose();
    contactBox.close();
  }

  bool contactSelected = false;
  bool searchSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: !searchSelected,
          child: const Text('Choose contact'),
        ),
        leading: IconButton(
          icon: searchSelected ? const Icon(Icons.arrow_back) : const Icon(Icons.cancel),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () {
            if (searchSelected == false) {
              Navigator.of(context).pop();
            } else {
              searchSelected = false;
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
      floatingActionButton: FloatingActionButton(
        child: contactSelected == false ? const Icon(Icons.add) : const Icon(Icons.check),
        onPressed: () {
          if (contactSelected == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddContactPage"),
                builder: (context) => const AddContactPage(),
              ),
            );
          } else {
            // Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "AssignSplitPage"),
                    builder: (context) => const AssignSplitPage()));
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
                  onTap: () {},
                  child: ContactList("Xevenst ${contactBox.length}"));
            },
          );
        },
      ),
    );
  }

  void addContact() async {
    final box = Hive.box<Contact>('Contact');
    print(contactBox.length);
    Contact temp = Contact(contactName: "Xevenst");
    await box.put(box.length, temp);
    setState(() {
      contactSelected = true;
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
