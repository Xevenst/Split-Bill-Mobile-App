import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/classes/contact.dart';
import 'package:splitbill/lists/contactlist.dart';
import 'package:splitbill/pages/confirmationpage.dart';

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
  bool deleteContactSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: (!searchSelected || deleteContactSelected),
          child: deleteContactSelected == false
              ? Text('Choose contact')
              : Text('Delete contact'),
        ),
        leading: IconButton(
          icon: (deleteContactSelected == false && searchSelected == false)
              ? Icon(Icons.arrow_back)
              : Icon(Icons.cancel),
          // tooltip: 'Go back',
          color: Colors.white,
          onPressed: () {
            if (deleteContactSelected == false && searchSelected == false) {
              Navigator.of(context).pop();
            } else {
              deleteContactSelected = false;
              searchSelected = false;
            }
            setState(() {});
          },
        ),
        actions: [
          Visibility(
              visible: (!searchSelected && !deleteContactSelected),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchSelected = true;
                  setState(() {});
                },
              )),
          Visibility(
            visible: !deleteContactSelected,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteContactSelected = true;
                setState(() {});
              },
            ),
          ),
          IconButton(
            onPressed: () {
              addContact();
            },
            icon: Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              resetContact();
            },
            icon: Icon(Icons.restore),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: contactSelected == false ? Icon(Icons.add) : Icon(Icons.check),
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
                    settings: const RouteSettings(name: "ConfirmationPage"),
                    builder: (context) => const ConfirmationPage()));
          }
          contactSelected = false;
          searchSelected = false;
          deleteContactSelected = false;
          setState(() {});
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Contact>('Contact').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return InkWell(onTap: () {}, child: ContactList("Xevenst ${contactBox.length}"));
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
