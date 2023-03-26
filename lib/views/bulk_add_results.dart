import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// See https://docs.flutter.dev/cookbook/networking/fetch-data

class Response {
  final List displayNames;

  Response({required this.displayNames});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        displayNames: json['predictions'][0]['displayNames'] as List);
  }

  @override
  String toString() {
    String str = "";
    for (var i = 0; i < displayNames.length; i++) {
      str += displayNames[i] + ", ";
    }
    return str;
  }
}

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
            'Bearer ya29.a0Ael9sCP3Igio52WFZJXQWD8vYlv1mqJDjp2FLwuvBssQOBkwi7ev8hcFAOh03WseZMRJYpto1GYzD0xIRPQBVxzByxbFL200L8Pc_84QX5RtFWOlANxAHQOO7KBGMwTZlv1PnUpCr3b6p67uN8Ru5lnKey3999NhjGhOfCi0zCDSteKR1psOhYgIIyinw62NVrzdMQFAMeY4MSt8etRW0eU9mjrPP6Y5JTh26xgaCgYKAQ0SARASFQF4udJhwwU2jxRFdckz5YIl879fBQ0238',
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
        if (snapshot.hasData) {
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: const Text(
                    "Does this match with what you have in your photo?",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

                const SizedBox(height: 25),
                
              Text(snapshot.data.toString(), style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),

              const SizedBox(height: 25),

            Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10), backgroundColor: Colors.green), 
                    child: const Text(
                      "Yes",
                      style: TextStyle(fontSize: 20),
                    ))),

            Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10), backgroundColor: Colors.red), 
                    child: const Text(
                      "No",
                      style: TextStyle(fontSize: 20),
                    ))),
          ],
        );


        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
