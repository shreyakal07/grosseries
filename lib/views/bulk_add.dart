import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BulkAdd extends StatefulWidget {
  const BulkAdd({super.key});

  @override
  State<BulkAdd> createState() => _BulkAddState();
}

class _BulkAddState extends State<BulkAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 1,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black),
            onPressed: (() => GoRouter.of(context).pop()),
          ),
          title: const Text('Bulk Add'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.black),
              onPressed: (() => GoRouter.of(context).go("/edit_profile_more")),
            ),
          ],
        ),
        body: Container());
  }
}
