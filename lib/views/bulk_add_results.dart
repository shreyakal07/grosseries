import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grosseries/models/Response.dart';
import 'package:grosseries/models/checkbox_state.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../view_models/food_list_entry_view_model.dart';
import '../view_models/user_view_model.dart';

class BulkAddResults extends StatefulWidget {
  final String? imageBytes;

  const BulkAddResults({super.key, this.imageBytes});

  @override
  State<BulkAddResults> createState() => _BulkAddResultsState();
}

class _BulkAddResultsState extends State<BulkAddResults> {
  late Future<Response>? futureResponse;
  Map food = {};
  bool checkBoxValue = false;
  final checkboxes = [];
  final allCheckboxes = CheckboxState(label: "All Labeled Items", value: false);

  Future<Response> getLabel() async {
    Map json = {
      "instances": [
        {"content": widget.imageBytes}
      ],
      "parameters": {"confidenceThreshold": 0.5, "maxPredictions": 5}
    };

    final response = await http.post(
      Uri.parse(
          'https://us-central1-aiplatform.googleapis.com/v1/projects/844535666912/locations/us-central1/endpoints/7942709271332913152:predict'),
      headers: <String, String>{
        "Authorization":
            'Bearer ya29.a0Ael9sCNSs5OURTT7sCR4i7SoumLCsmIDyzjkUbWk8Cwl9vC00ycKiabnnHd5toOr3jjdq5UD5MIOxCgXdEZuxyRfjwPgUyGklneC0qk6XLLo_wivOuSF6QCihxZQd-o3NDKTCYWnYxaWxnpY3ykQ5I5puWAxy3DzH_hDXzq6roaCMcMjlTH7wdDnTtV_mFV5i3_Xam6CkoeEQm4mX2Y1erh_5VpW6ZmT5vp-HOQaCgYKATUSARESFQF4udJhPiDUzIA3HSuM1ZeR7T6F7Q0238',
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
    User? currentUser = context.watch<UserViewModel>().currentUser;

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
        child: (futureResponse == null)
            ? null
            : buildFutureBuilder(context, currentUser, food),
      ),
    );
  }

  FutureBuilder<Response> buildFutureBuilder(context, currentUser, food) {
    void toggleAllCheckboxes(bool? value) {
      if (value == null) return;

      setState(() {
        allCheckboxes.value = value;
        checkboxes.forEach((checkbox) => checkbox.value = value);
      });
    }

    Widget buildCheckbox(CheckboxState checkbox) => CheckboxListTile(
          activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.leading,
          value: checkbox.value,
          title: Row(
            children: [
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            FoodItemViewModel.getFoodItemByName(checkbox.label)!
                                .image),
                      ))),
              Text(checkbox.label,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold))
            ],
          ),
          onChanged: (value) => setState(() {
            checkbox.value = value!;
          }),
        );

    Widget buildAllCheckbox(CheckboxState checkbox) => CheckboxListTile(
        activeColor: Colors.green,
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.value,
        title: Text(checkbox.label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        onChanged: (value) => toggleAllCheckboxes(value));

    return FutureBuilder<Response>(
      future: futureResponse,
      builder: (context, snapshot) {
        List labels;

        if (snapshot.hasData) {
          labels = snapshot.data!.displayNames;
          // removes the 's' from the end of the label
          for (int i = 0; i < labels.length; i++) {
            if (labels[i].substring(labels[i].length - 2) == 'es') {
              labels[i] = labels[i].substring(0, labels[i].length - 2);
            } else if (labels[i][labels[i].length - 1] == 's') {
              labels[i] = labels[i].substring(0, labels[i].length - 1);
            }
            if (FoodItemViewModel.getFoodItemByName(labels[i]) != null) {
              food[labels[i]] = {
                'index': i,
                'id': FoodItemViewModel.getFoodItemByName(labels[i])!.id,
                'quantity': 1,
                'storage': "Fridge",
                'owner': currentUser.email,
                'datePurchased': DateTime.now(),
                // 'checkbox': CheckboxState(value: false),
              };
              checkboxes.add(CheckboxState(label: labels[i], value: false));
            }
          }
          // debugPrint(food.toString());

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  child: const Text(
                      "Select all ingredients that match with photo.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 25),
              buildAllCheckbox(allCheckboxes),
              Expanded(
                  child: ListView.builder(
                itemCount: labels.length,
                itemBuilder: (context, index) => FoodItemViewModel
                            .getFoodItemByName(labels[index]) !=
                        null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child:
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            buildCheckbox(checkboxes[index])
                        // ],
                        // )
                        )
                    : Text(
                        "${labels[index]} has been detected but is not in our inventory."),
              )),
              ElevatedButton(
                  onPressed: () {
                    food.forEach((key, value) {
                      if (checkboxes[food[key]['index']].value == true) {
                        context.read<FoodListEntryViewModel>().addFoodItemEntry(
                              food[key]['id'],
                              food[key]['storage'],
                              food[key]['quantity'],
                              food[key]['owner'],
                              food[key]['datePurchased'],
                              currentUser?.notificationsEnabled,
                              currentUser?.notificationDayAmount,
                            );
                        GoRouter.of(context).go("/");
                      }
                    });
                  },
                  child: const Text("Add Items")),
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
                          Navigator.pop(context);
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
