import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// See https://docs.flutter.dev/cookbook/networking/fetch-data

class Response {
  final String contentType;
  final String data;
  var extensions;

  Response({
    required this.contentType,
    required this.data,
    this.extensions,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      contentType: json['contentType'],
      data: json['data'],
      extensions: json['extensions'],
    );
  }
}

class BulkAddResults extends StatefulWidget {
  final String? imageBytes;

  const BulkAddResults({super.key, this.imageBytes});

  @override
  State<BulkAddResults> createState() => _BulkAddResultsState();
}

class _BulkAddResultsState extends State<BulkAddResults> {
  late Future<Response> futureAlbum;
  late var test;

  Future<Response> createAlbum() async {
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
            'Bearer ya29.a0Ael9sCP5jZXjWBaI-PpI22fhHXb4fkA7PSuZhLdPKWDhfwm68FFM8AN0JgPSBLCizpOd2Uo70cvAGT9V6mehWwfFIrQBLFYgGv2x3T23zn_Nh981q9OVMtYGornTBPe7L8JQV9g_v3fWtLt_Jtf2yF3_o12Ve6_8yxmBo0Ff9zvcWpmpcT7KUfB_rUTsKRu0VuHy4k_T_6pMFL5o8dIGoGcfOVctg-NHIpp3DQsaCgYKAR8SARASFQF4udJh58WYW7i9v2Rk3T63XCEAig0238',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(json),
    );

    print("HELLOHERE" + response.statusCode.toString());

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print(response.body);
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
    // futureAlbum = createAlbum();
    test = createAlbum();
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
        body: Text("JSON Response: " + test.contentType)
        // Center(
        //   child: FutureBuilder<Album>(
        //     future: futureAlbum,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.title);
        //       } else if (snapshot.hasError) {
        //         return Text('${snapshot.error}');
        //       }

        //       // By default, show a loading spinner.
        //       return const CircularProgressIndicator();
        //     },
        //   ),
        // )
        );
  }
}
