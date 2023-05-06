import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_akademiya/first_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    var username = _usernameController.text;
    var parol = _passwordController.text;

    final response = await http.post(
      Uri.parse(
          'https://namoz-qr-web-app-production.up.railway.app/users/signin?password=$parol&username=$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => firstScreen()));
      print("kirdi");
      print(response.body);
    } else {
      print("error xato");
      print(response.body);
    }

    setState(() {
      _isLoading = false;
    });
  }
// get data
  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0c2htZXN0IiwiYXV0aCI6W3siYXV0aG9yaXR5IjoiUk9MRV9DTElFTlQifV0sImlhdCI6MTY4MzIwMTY5NSwiZXhwIjoxNjgzNTAxNjk1fQ.Hs5XjEQoe4ds3X_YzDYxgBHp7pTG3DpNLQFgFrUS-pc"';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "https://namoz-qr-web-app-production.up.railway.app/students/";
    http.Response response2 = await http.get(myUrl as Uri,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $key'
    });
    if (response2.statusCode == 200) {
      print("kirsa kk");
      print(response2.body);
    } else {
      print("error xato");
      print(response2.body);
    }
    return json.decode(response2.body);


   print(response2.body); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Foydalanuvchi nomi',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Parol',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)), 
                ),
                backgroundColor: Color.fromARGB(255, 221, 179, 146)
              ),
              onPressed: _isLoading ? null : _login,
              child: _isLoading ? CircularProgressIndicator(color: Color.fromARGB(255, 221, 179, 146),) : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
