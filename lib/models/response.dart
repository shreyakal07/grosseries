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
      str += displayNames[i];
      if (i != displayNames.length - 1) {
        str += ", ";
      }
    }
    return str;
  }
}
