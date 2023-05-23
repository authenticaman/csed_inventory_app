import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csed_inventory/screens/view_item_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScannerScreen extends StatefulWidget {
  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  late Size size;

  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('item');

  QRViewController? _controller;
  Barcode? result;

  bool _isBuild = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    if (!_isBuild && _controller != null) {
      _controller?.pauseCamera();
      _controller?.resumeCamera();
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/qrcodd.png",
                width: 40.0,
                height: 40.0,
              ),
              Text("QR Code Scanner"),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 9, child: _buildQrView(context)),
            Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xffe3dfdf),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            await _controller?.toggleFlash();
                          },
                          child: const Icon(
                            Icons.flash_on,
                            size: 24,
                            //color: Color(0xffbd07f8),
                            color: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () async {
                          await _controller?.flipCamera();
                        },
                        child: const Icon(
                          Icons.flip_camera_ios,
                          size: 24,
                          color: Colors.deepPurple,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 250.0;

    return QRView(
      key: _qrKey,
      onQRViewCreated: onQRViewCreated,
      onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
          cutOutSize: scanArea,
          borderWidth: 10,
          borderLength: 40,
          borderRadius: 5.0,
          borderColor: Colors.deepPurple),
    );
  }

  void onQRViewCreated(QRViewController _qrController) {
    setState(() {
      this._controller = _qrController;
    });

    _controller?.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });

      if (result?.code != null) {
        print("QR Code Scanned and Showing Result");
        _showResult();
      }
    });
  }

  void onPermissionSet(
      BuildContext context, QRViewController _ctrl, bool _permission) {
    if (!_permission) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Permission!")));
    }
  }

  //creating a result view
  bool _scanned_result = false;
  bool _validURL = false;

  Widget _showResult() {
    //now check if it is url or not, if url then launch it.
    bool:
    //? const ViewItemScreen() : _validURL;
    _scanned_result = Uri.parse(result!.code.toString()).isAbsolute;
    _validURL = Uri.parse(result!.code.toString()).isAbsolute;

    return SafeArea(
      child: Center(
        child: FutureBuilder<dynamic>(
          future: showDialog(
              context: context,
              builder: (BuildContext context) {
                return WillPopScope(
                  child: AlertDialog(
                    title: const Text(
                      "Scan Result!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: SizedBox(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // home: _isSignedIn ? const MyHomePage() : SplashScreen(),
                          _scanned_result
                              ? Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: SelectableText.rich(
                                    TextSpan(
                                        text: result!.code.toString(),
                                        style: const TextStyle(
                                            color: Colors.blueAccent),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrl(Uri.parse(
                                                result!.code.toString()));
                                          }),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    print("got here ");
                                    print(Uri.parse(result!.code.toString())
                                        .toString());
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            //here trying to call my code .... to get data from firebase ....
                                            // builder: (context) =>
                                            //     const ViewScreen()));
                                            builder: (context) => GetItem(
                                                Uri.parse(result!.code.toString())
                                                    .toString())));
                                    _controller?.pauseCamera();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: const Text(
                                      "click to see scanned result here !!",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )),
                          MaterialButton(
                              color: Colors.deepPurple,
                              onPressed: () {
                                Navigator.pop(context);
                                _controller?.resumeCamera();
                              },
                              child: const Text("Close",style: TextStyle(color: Colors.white),))
                        ],
                      ),
                    ),
                  ),
                  onWillPop: () async => false,
                );
              }),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            throw UnimplementedError;
          },
        ),
      ),
    );
  }
}
