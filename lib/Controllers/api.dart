import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_akademiya/result_screen.dart' as code;

class MyListView extends StatefulWidget {
  
  @override
  _MyListViewState createState() => _MyListViewState();

  
}

class _MyListViewState extends State<MyListView> {
  
  List<dynamic> _data = [];
  String err = 'error ishlamadi';

  String? getNameFromId() {
    for (int i = 0; i < _data.length; i++) {
      if (_data[i]["passportNo"] == code.ResultScreen) {
        return _data[i]["firstname"];
      }
    }
    return err;
  }


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var headers = {
        'Authorization': 'Bearer zI1NiJ9.eyJzdWIiOiJ0ZXN0c2htZXN0IiwiYXV0aCI6W3siYXV0aG9yaXR5IjoiUk9MRV9DTElFTlQifV0sImlhdCI6MTY4MzUzNjA1NywiZXhwIjoxNjgzODM2MDU3fQ.hJ4-97Na6uMXYtovszy1BsN5vq1KmSAu1-ZIFrzpvug'
      };
    var request = http.Request('GET', Uri.parse('https://example.com'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      setState(() {
        _data = json.decode(responseBody);
        final datalist = _data.cast<Map<String, dynamic>>();
        print(_data);
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _data[index];
          getNameFromId() != null;
            
          return ListTile(
            title: Text(item['firstname']),
            subtitle: Text(item['lastname']),
          );
          
        },
      ),
    );
  }
}