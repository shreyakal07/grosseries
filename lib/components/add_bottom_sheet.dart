import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({
    super.key,
  });

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Center(
          child: Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        const Text("Add to List",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go("/add_item");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.only(left: 5)),
                child: Row(children: [
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.search,
                      )),
                  const Text("Browse & search common ingredients",
                      style: TextStyle(fontSize: 18))
                ]))),
        Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go("/bulk_add");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.only(left: 5)),
                child: Row(children: [
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.photo_camera,
                      )),
                  const Text("Bulk add with a photo",
                      style: TextStyle(fontSize: 18))
                ]))),
      ],
    ));
  }
}
