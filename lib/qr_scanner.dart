import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_akademiya/result_screen.dart';
import 'package:flutter/services.dart';
// import 'Controllers/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const bgColor = Color(0xfffafafa);
const btnColor = Color.fromARGB(255, 221, 179, 146);

class QRScanner extends StatefulWidget {
QRScanner({Key? key}) : super(key: key);
 

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isfrontcamera = false;
  late final String code;
  MobileScannerController controller = MobileScannerController();

  List<dynamic> _data = [];
  late final datalist;
  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
// -------------------------------
  Future<void> _fetchData() async {
    var headers = {
        'Authorization': 'Bearer JzdWIiOiJ0ZXN0c2htZXN0IiwiYXV0aCI6W3siYXV0aG9yaXR5IjoiUk9MRV9DTElFTlQifV0sImlhdCI6MTY4MzUzNjA1NywiZXhwIjoxNjgzODM2MDU3fQ.hJ4-97Na6uMXYtovszy1BsN5vq1KmSAu1-ZIFrzpvug',
      };
    var request = http.Request('GET', Uri.parse('https://example.com/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      setState(() {
        _data = json.decode(responseBody);
        datalist = _data.cast<Map<String, dynamic>>();
        // print(_data);
        print(datalist);
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
// --------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            closeScreen();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 221, 179, 146),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Color.fromARGB(255, 221, 179, 146) : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isfrontcamera = !isfrontcamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.flip_camera_ios,
                color: isfrontcamera ? Color.fromARGB(255, 221, 179, 146) : Colors.grey,
              ))
        ],
        iconTheme: IconThemeData(color: bgColor),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Expanded(
            //     child: Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "QR Codeni qo'ying",
            //         style: TextStyle(
            //             color: Colors.black87,
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 1),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         "Skanerlash avtomatik boshlanadi",
            //         style: TextStyle(fontSize: 16, color: Colors.black54),
            //       )
            //     ],
            //   ),
            //   // color: Colors.brown,
            // )),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          
                          String getNameFromId() {
                            for (int i = 0; i < datalist.length; i++) {
                              if (datalist[i]["passportNo"] == code) {
                                return datalist[i]["firstname"];
                              }
                            }
                            return 'ishlamadi';
                          }
                        }
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child:
                
                 ListView.builder(
                itemCount: _data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _data[index];
                  return ListTile(
                    title: Text(item['firstname']),
                    subtitle: Text(item["lastname"]),
                  );
                  
                },
              ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Container(
                  width: 350,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: Color.fromARGB(255, 221, 179, 146),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Yuborish",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
