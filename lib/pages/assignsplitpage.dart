import 'package:flutter/material.dart';
import 'package:splitbill/pages/selectitempage.dart';

class AssignSplitPage extends StatefulWidget {
  const AssignSplitPage({
    super.key,
    required this.storeIndex,
    required this.contactIndex,
    required this.itemSelected,
  });

  final int storeIndex;
  final List<int> contactIndex;
  final List<ItemSelected> itemSelected;
  
  @override
  State<AssignSplitPage> createState() => _AssignSplitPageState();
}

class _AssignSplitPageState extends State<AssignSplitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Splits'),
      ),
    );
  }
}
