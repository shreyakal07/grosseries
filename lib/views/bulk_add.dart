import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class BulkAdd extends StatefulWidget {
  const BulkAdd({super.key});

  @override
  State<BulkAdd> createState() => _BulkAddState();
}

class _BulkAddState extends State<BulkAdd> {
  File? image;
  final _picker = ImagePicker();

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 1,
          centerTitle: false,
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
                      pickImageCamera();
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
                    onPressed: () {
                      pickImage();
                      if (image != null) {
                        List<int> imageBytes = image!.readAsBytesSync();
                        GoRouter.of(context).go(
                            "/bulk_add_results/${base64Encode(imageBytes)}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10)),
                    child: const Text("Upload from Gallery",
                        style: TextStyle(fontSize: 20)))),
            // image != null ? Image.file(image!) : const Text("no image")
          ],
        ));
  }
}
