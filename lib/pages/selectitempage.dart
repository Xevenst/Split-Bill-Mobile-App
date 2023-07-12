import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/lists/itemlist.dart';
import 'package:splitbill/pages/assignsplitpage.dart';
import '../classes/item.dart';
import '../classes/store.dart';
import '../lists/itemCard.dart';

class ItemSelected {
  Item item;
  int quantity;
  ItemSelected({
    required this.item,
    required this.quantity,
  });
  void addQuantity() {
    quantity += 1;
  }

  void reduceQuantity() {
    quantity -= 1;
  }

  Item getItem() {
    return item;
  }
}

class SelectItemPage extends StatefulWidget {
  const SelectItemPage({
    super.key,
    required this.storeIndex,
    required this.contactIndex,
  });
  final int storeIndex;
  final List<int> contactIndex;

  @override
  State<SelectItemPage> createState() => _SelectItemPageState();
}

class _SelectItemPageState extends State<SelectItemPage> {
  ValueNotifier<bool> selected = ValueNotifier<bool>(false);
  late final List<Item> storeItems =
      storeBox.getAt(widget.storeIndex).storeItems;
  late ValueNotifier<List<int>> count;
  late ValueNotifier<num> totalprice;
  ValueNotifier<List<ItemSelected>> selectedItem =
      ValueNotifier<List<ItemSelected>>([]);
  late Box storeBox;

  @override
  void initState() {
    super.initState();
    storeBox = Hive.box<Store>('Store');
    count = ValueNotifier<List<int>>(List.filled(storeItems.length, 0));
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
                    storeIndex: widget.storeIndex,
                    contactIndex: widget.contactIndex,
                    itemSelected: selectedItem.value),
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
                itemCount: storeItems.length,
                itemBuilder: (context, index) {
                  return ItemList(
                      storeItems[index],
                      selectedItem.value
                          .any((e) => e.item == storeItems[index]),
                      setState,
                      count,
                      storeBox.getAt(widget.storeIndex).storeCurrency,
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
          totalprice.value.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
