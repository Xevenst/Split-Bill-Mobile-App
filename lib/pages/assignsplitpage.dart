import 'package:flutter/material.dart';

class AssignSplitPage extends StatefulWidget {
  const AssignSplitPage({super.key});

  @override
  State<AssignSplitPage> createState() => _AssignSplitPageState();
}

class _AssignSplitPageState extends State<AssignSplitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Confirmation'),
        actions: [],
      ),
      body: const Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          setState(() {});
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
