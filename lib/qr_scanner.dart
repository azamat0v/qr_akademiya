import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_akademiya/result_screen.dart';

const bgColor = Color(0xfffafafa);
const btnColor = Color(0xffddb392);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isfrontcamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

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
            color: Colors.brown,
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
                color: isFlashOn ? Colors.brown : Colors.grey,
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
                color: isfrontcamera ? Colors.brown : Colors.grey,
              ))
        ],
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
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "QR Codeni qo'ying",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Skanerlash avtomatik boshlanadi",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
              // color: Colors.brown,
            )),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        closeScreen: closeScreen,
                                        code: code,
                                      )));
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
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    ListTile(
                        title: Text("Ism"),
                        trailing: Icon(Icons.delete, color: Colors.brown)),
                    ListTile(
                        title: Text("Ism"),
                        trailing: Icon(Icons.delete, color: Colors.brown)),
                    ListTile(
                        title: Text("Ism"),
                        trailing: Icon(Icons.delete, color: Colors.brown)),
                    ListTile(
                        title: Text("Ism"),
                        trailing: Icon(Icons.delete, color: Colors.brown)),
                    ListTile(
                        title: Text("Ism"),
                        trailing: Icon(Icons.delete, color: Colors.brown))
                  ],
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
                      backgroundColor: Colors.brown,
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
