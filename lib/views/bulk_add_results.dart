import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grosseries/models/Response.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';
import 'package:http/http.dart' as http;

class BulkAddResults extends StatefulWidget {
  final String? imageBytes;

  const BulkAddResults({super.key, this.imageBytes});

  @override
  State<BulkAddResults> createState() => _BulkAddResultsState();
}

class _BulkAddResultsState extends State<BulkAddResults> {
  late Future<Response>? futureResponse;

  Future<Response> getLabel() async {
    Map json = {
      "instances": [
        {"content": widget.imageBytes}
      ],
      "parameters": {"confidenceThreshold": 0.5, "maxPredictions": 5}
    };

    final response = await http.post(
      Uri.parse(
          'https://us-central1-aiplatform.googleapis.com/v1/projects/361247076963/locations/us-central1/endpoints/333490672797483008:predict'),
      headers: <String, String>{
        "Authorization":
            'Bearer ya29.a0Ael9sCNncjCXbgWF6hFVnQ4ge9BfVDENfbYA40oquT7y0kd_Haw23MrK58jJq4XbEgVb-8cYCYxjsAlqblq3OVfxMH4n2Gb4OyPQoeUpTboLm2Th-Pk26drGqtR_ixbYjAKtcei4KlfgejlZF-3OeGRwhcsHqn8SaJ0aWERAjpbP0slkweVcdJsU63y4nVnNCYANnS5v9zr5VpLKpBCLIBQaDdMPD8IZRhcYzwaCgYKAZQSARESFQF4udJhB4Owxu0BBPhC6cJKh2p6SA0237',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(json),
    );

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to identify image.');
    }
  }

  @override
  void initState() {
    super.initState();
    futureResponse = getLabel();
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
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (futureResponse == null) ? null : buildFutureBuilder(),
      ),
    );
  }

  FutureBuilder<Response> buildFutureBuilder() {
    return FutureBuilder<Response>(
      future: futureResponse,
      builder: (context, snapshot) {
        List labels;

        if (snapshot.hasData) {
          labels = snapshot.data!.displayNames;
          // removes the 's' from the end of the label
          for (int i = 0; i < labels.length; i++) {
            if (labels[i][labels[i].length - 1] == 's') {
              labels[i] = labels[i].substring(0, labels[i].length - 1);
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  child: const Text(
                      "Does this match with what you have in your photo?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.green),
                          child: const Text(
                            "Yes",
                            style: TextStyle(fontSize: 20),
                          ))),
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.red),
                          child: const Text(
                            "No",
                            style: TextStyle(fontSize: 20),
                          ))),
                ],
              ),
              const SizedBox(height: 25),
              // needs to be updated if we have multiple labels
              FoodItemViewModel.getFoodItemByName(labels[0]) != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      FoodItemViewModel.getFoodItemByName(
                                              labels[0])!
                                          .image),
                                ))),
                        Text(snapshot.data.toString(),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold))
                      ],
                    )
                  : Text(
                      "${snapshot.data} has been detected but is not in our inventory."),
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    textAlign: TextAlign.center,
                    "Aw Shucks!",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Container(
                    height: 200,
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/sad-corn-cartoon.jpg"),
                        ))),
                const Text(
                  textAlign: TextAlign.center,
                  "Something went wrong.\n We could not identify the image.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: ElevatedButton(
                        onPressed: () {
                          // this does not work.
                          // navigator does work but i don't want to do that becuase of the back button offsetting the title of the page
                          // need to figure out how to do replace navigator with goRouter in bulk_add.dart
                          GoRouter.of(context).go("/bulk_add");
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.orange),
                        child: const Text(
                          "Try Again",
                          style: TextStyle(fontSize: 20),
                        ))),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).go("/add_item");
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.orange),
                        child: const Text(
                          "Add Item Manually",
                          style: TextStyle(fontSize: 20),
                        )))
              ]);
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
