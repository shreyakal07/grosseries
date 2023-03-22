import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/add_bottom_sheet.dart';

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
          // leading: IconButton(
          //     icon: const Icon(Icons.chevron_left, color: Colors.black),
          //     onPressed: (() {
          //       GoRouter.of(context).go('/');
          //     })),
          title: const Center(child: Text('Bulk Add To List')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: const Text(
                    "Add multiple ingredients from your kitchen with a photo!",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            const SizedBox(height: 50),
            Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/take_picture_screen');
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10)),
                    child: const Text(
                      "Take a Photo",
                      style: TextStyle(fontSize: 20),
                    ))),
            Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10)),
                    child: const Text("Upload from Gallery",
                        style: TextStyle(fontSize: 20))))
          ],
        ));
  }
}
