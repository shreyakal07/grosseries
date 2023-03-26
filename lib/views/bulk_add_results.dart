import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// See https://docs.flutter.dev/cookbook/networking/fetch-data

class Predictions {
  final List<String> displayNames;

  Predictions({required this.displayNames});

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(displayNames: json['displayNames']);
  }
}

class Response {
  final Predictions displayNames;

  Response({required this.displayNames});

  factory Response.fromJson(Map<String, dynamic> json) {
    Predictions.fromJson(json['predictions']);
    return Response(displayNames: Predictions.fromJson(json['predictions']));

    // return Response(
    //     displayNames: json['predictions'][0]['displayNames'] as List);
  }

  @override
  String toString() {
    // TODO: implement toString
    String str = "";
    for (var i = 0; i < displayNames.displayNames.length; i++) {
      str += displayNames.displayNames[i] + ", ";
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
    print("ENTERED");
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

    print("HELLOHERE" + response.statusCode.toString());

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print(response.body);
      var j = jsonDecode(response.body);
      if (j == null) {
        print("THIS IS NULL");
      } else {
        print(j.toString());
        print(j['predictions'][0]['displayNames']);
        print(j['predictions'][0]['displayNames'].runtimeType);
      }

      return Response.fromJson(jsonDecode(response.body));
      // return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("ERROR");
      throw Exception('Failed to create album.');
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
      body:
          // Text("Label: " + futureResponse.toString())
          Container(
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
          return Text(snapshot.data.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
