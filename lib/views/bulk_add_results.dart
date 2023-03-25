import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// See https://docs.flutter.dev/cookbook/networking/fetch-data

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
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
  late Future<Album> futureAlbum;

  Future<Album> createAlbum() async {
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
            'Bearer ya29.a0Ael9sCMcOWJySPEq10pEZJAlTmtiYVjs2Lkkk6rjEzzi-G37sAHfyMkcuX4n3NVwZ2jvx7uEwjjeQ_OqbWCmdU7CB27Jpje-fep8KnzyyHqxTOMie-l-kf21fM-19MrATjAUs1-xi1t64nT7SVl3gLLCfdl5_0_Clp1Ky9YkQwZsts0kBA_0MCAsEma0kHZuFvMGd8u7prSARJ3d9Csevm572Q3VpMJmMlCbKQaCgYKAbYSARASFQF4udJhyUsqYDaLooSadl4uaJc1Cw0237',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(json),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = createAlbum();
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
        body: const Text("Placeholder so this works")
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
