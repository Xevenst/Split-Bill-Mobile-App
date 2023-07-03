import 'package:flutter/material.dart';

class ViewStorePage extends StatefulWidget {
  const ViewStorePage({super.key});

  @override
  State<ViewStorePage> createState() => _ViewStorePageState();
}

class _ViewStorePageState extends State<ViewStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Store'),
      ),
    );
  }
}
