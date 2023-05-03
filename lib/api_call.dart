import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://namoz-qr-web-app-production.up.railway.app/students/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  // final String firstname;
  final String lastname;
  final String passportNo;
  final String classNo;
  final int courseNo;
  final bool isSick;
  final bool isInOut;

  const Album(
      {required this.id,
      // required this.firstname,
      required this.lastname,
      required this.passportNo,
      required this.classNo,
      required this.courseNo,
      required this.isSick,
      required this.isInOut});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        // firstname: json['firstname'],
        lastname: json['lastname'],
        passportNo: json['passportNo'],
        classNo: json['classNo'],
        courseNo: json['courseNo'],
        isSick: json['isSick'],
        isInOut: json['isInOut']);
  }
}

void main() => runApp(const ApiCall());

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _MyAppState();
}

class _MyAppState extends State<ApiCall> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.lastname);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
