import 'package:flutter/material.dart';

import 'addcontactpage.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  bool contactSelected = false;
  bool searchSelected = false;
  bool deleteContactSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: (!searchSelected||deleteContactSelected),
          child: deleteContactSelected == false? Text('Choose contact'): Text('Delete contact'),
        ),
        leading: IconButton(
          icon: (deleteContactSelected == false && searchSelected == false)? Icon(Icons.arrow_back): Icon(Icons.cancel),
          // tooltip: 'Go back',
          color:Colors.white,
          onPressed: (){
            if(deleteContactSelected==false && searchSelected == false){
              Navigator.pop(context);
            }
            else{
              deleteContactSelected = false;
              searchSelected = false;
            }
            setState(() {
                
            });
          },
        ),
        actions: [
          Visibility(
            visible: (!searchSelected &&!deleteContactSelected),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                searchSelected=true;
                setState(() {
                  
                });
              },
            )
          ),
          Visibility(
            visible: !deleteContactSelected,
            child: IconButton(icon: Icon(Icons.delete),onPressed: (){
              deleteContactSelected = true;
              setState(() {
                
              });
            },),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: contactSelected == false? Icon(Icons.add) : Icon(Icons.check),
        onPressed: () {
          if(contactSelected==false){
            Navigator.push(context,MaterialPageRoute(settings: const RouteSettings(name: "AddContactPage"), builder: (context) => const AddContactPage(),));
          }
          else{
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          contactSelected = false;
          searchSelected = false;
          deleteContactSelected = false;
          setState(() {
            
          });
        },
      ),
    );
  }
}