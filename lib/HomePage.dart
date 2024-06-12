// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> scannedResults = [];
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "SCAN MASTER",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [

                  //camera
                  MobileScanner(
                    controller: cameraController,
                    allowDuplicates: true,
                    onDetect: (barcode, args)// if you want qr code change the barcode to qrcode
                    {
                      setState(() {
                        String resultToAdd = barcode.rawValue ?? "---";
                        if (!scannedResults.contains(resultToAdd)) {
                          scannedResults.insert(0, resultToAdd); // Insert at the beginning
                        }
                      });
                    },
                  ),

                  // Border in camera
                  QRScannerOverlay(

                    overlayColor: Colors.black26,
                    borderColor: Colors.blue,
                    borderRadius: 20,
                    borderStrokeWidth: 5,
                  ),
                ],
              ),
            ),

            //List Of BarCodes

            Expanded(
              child: ListView.builder(
                itemCount: scannedResults.length,
                itemBuilder: (context, index) {
                  return
                    ListTile(

                        title: Text("Barcode ${index + 1}: ${scannedResults[index]}"),
                    );






                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
