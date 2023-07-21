import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/lists/itemlist.dart';
import 'package:splitbill/pages/assignsplitpage.dart';
import '../classes/contact.dart';
import '../classes/item.dart';
import '../classes/store.dart';

class ItemSelected {
  Item item;
  int quantity;
  num totalItemPrice;
  ItemSelected({
    required this.item,
    required this.quantity,
    required this.totalItemPrice,
  });
  void addQuantity() {
    quantity += 1;
    totalItemPrice = quantity*item.itemPrice;
  }

  void reduceQuantity() {
    quantity -= 1;
    totalItemPrice = quantity*item.itemPrice;
  }

  Item getItem() {
    return item;
  }
  int getQuantity(){
    return quantity;
  }
  num getTotalItemPrice(){
    return totalItemPrice;
  }
}

class SelectItemPage extends StatefulWidget {
  const SelectItemPage({
    super.key,
    required this.store,
    required this.contact,
  });
  final Store store;
  final List<Contact> contact;

  @override
  State<SelectItemPage> createState() => _SelectItemPageState();
}

class _SelectItemPageState extends State<SelectItemPage> {
  ValueNotifier<bool> selected = ValueNotifier<bool>(false);
  late final List<Item>? storeItems =
      widget.store.storeItems;
  late ValueNotifier<List<int>> count;
  late ValueNotifier<num> totalprice;
  ValueNotifier<List<ItemSelected>> selectedItem =
      ValueNotifier<List<ItemSelected>>([]);
  late Box storeBox;

  @override
  void initState() {
    super.initState();
    storeBox = Hive.box<Store>('Store');
    count = ValueNotifier<List<int>>(List.filled(storeItems!.length, 0));
    totalprice = ValueNotifier<num>(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Item'),
      ),

      //FLOATING ACTION BUTTON ===================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selected.value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddStorePage"),
                builder: (context) => AssignSplitPage(
                    store: widget.store,
                    contact: widget.contact,
                    itemSelected: selectedItem.value,
                    totalprice: totalprice.value),
              ),
            );
            //TODO: SEND TO ASSIGN SPLITS
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please choose at least one item')));
          }
        },
        child: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,

      //BODY =====================================================
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: ListView.builder(
                itemCount: storeItems!.length,
                itemBuilder: (context, index) {
                  return ItemList(
                      storeItems![index],
                      selectedItem.value
                          .any((e) => e.item == storeItems![index]),
                      setState,
                      count,
                      widget.store.storeCurrency,
                      totalprice,
                      index,
                      selectedItem,
                      selected);
                },
              ),
            ),
          ),
          const Text('Chosen item(s): '),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: selectedItem.value.length,
              itemBuilder: (context, index) {
                return ItemCard(selectedItem.value[index]);
              },
            ),
          ),
        ],
      ),

      //BOTTOM NAVBAR ===============================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(25),
        height: 80.0,
        color: Colors.blue[200],
        child: Text(
          'Total price: ${totalprice.value.toString()}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
