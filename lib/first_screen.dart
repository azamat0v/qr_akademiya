// import 'dart:js';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:qr_akademiya/login.dart';
import 'package:qr_akademiya/qr_scanner.dart';

const btnColor = Color(0xffddb392);

class firstScreen extends StatefulWidget {
  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: bgColor),
        centerTitle: true,
        title: const Text(
          "Shayx akademiyasi",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        actions: [
          IconButton(
              color: Color.fromARGB(255, 221, 179, 146),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 179, 146),
                shadowColor: Colors.black54,
                elevation: 5,
              ),
              onPressed: () {
                // String bomdod = 'bomdod';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanner()));
              },
              child: Text(
                'Bomdod',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 179, 146),
                shadowColor: Colors.black54,
                elevation: 5,
              ),
              onPressed: () {
                String peshin = "Peshin";
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanner()));
              },
              child: Text(
                'Peshin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 179, 146),
                shadowColor: Colors.black54,
                elevation: 5,
              ),
              onPressed: () {
                String asr = 'asr';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanner()));
              },
              child: Text(
                'Asr',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 179, 146),
                shadowColor: Colors.black54,
                elevation: 5,
              ),
              onPressed: () {
                String shom = 'shom';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanner()));
              },
              child: Text(
                'Shom',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 179, 146),
                shadowColor: Colors.black54,
                elevation: 5,
              ),
              onPressed: () {
                String xufton = 'xufton';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanner()));
              },
              child: Text(
                'Xufton',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
