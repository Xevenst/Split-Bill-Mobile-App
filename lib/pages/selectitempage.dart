import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitbill/lists/itemlist.dart';
import 'package:splitbill/pages/assignsplitpage.dart';
import '../classes/item.dart';
import '../classes/store.dart';
import '../lists/itemCard.dart';


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
  bool selected = false;
  late final List<Item> storeItems =
      storeBox.getAt(widget.storeIndex).storeItems;
  late ValueNotifier<List<int>> count;
  late ValueNotifier<num> totalprice;
  List<Item> itemSelected = [];
  late Box storeBox;

  @override
  void initState() {
    super.initState();
    storeBox = Hive.box<Store>('Store');
    count = ValueNotifier<List<int>>(List.filled(storeItems.length, 0));
    totalprice = ValueNotifier<num>(0);
    print(count);
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
          if (selected) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: "AddStorePage"),
                builder: (context) => AssignSplitPage(
                    storeIndex: widget.storeIndex,
                    contactIndex: widget.contactIndex,
                    itemSelected: itemSelected),
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
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (itemSelected.contains(storeItems[index])) {
                          itemSelected.remove(storeItems[index]);
                          if (itemSelected.isEmpty) {
                            selected = false;
                          }
                          totalprice.value -= storeItems[index].itemPrice;
                        } else {
                          itemSelected.add(storeItems[index]);
                          selected = true;
                          totalprice.value += storeItems[index].itemPrice;
                        }
                      });
                    },
                    child: ItemList(
                      storeItems[index],
                      itemSelected.contains(storeItems[index]),
                      setState,
                      count,
                      itemSelected,
                      storeBox.getAt(widget.storeIndex).storeCurrency,
                      totalprice,
                      index,
                    ),
                  );
                },
              ),
            ),
          ),
          const Text('Chosen item(s): '),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: itemSelected.length,
              itemBuilder: (context, index) {
                return ItemCard(itemSelected[index],count.value[index]);
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

