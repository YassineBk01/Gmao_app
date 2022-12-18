import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:signature/signature.dart';

class SignWidget extends StatefulWidget {
  @override
  _SignWidgetState createState() => _SignWidgetState();
}

class _SignWidgetState extends State<SignWidget> {
  late SignatureController controller;

  @override
  void initState() {
    super.initState();

    controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.blue.shade700,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Signature(
            controller: controller,
            backgroundColor: Colors.white,
            height: 250,

          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: buildButtons(context)
        ),

      ],
    ),
  );



  Widget buildButtons(BuildContext context) => Container(
    height: 100,

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildCheck(context),
        buildClear(),
      ],
    ),
  );

  Widget buildCheck(BuildContext context) => IconButton(
    iconSize: 36,
    icon: Icon(Icons.check, color: Colors.green),
    onPressed: () async {
      if (controller.isNotEmpty) {
        final signature = await exportSignature();




      }
    },
  );

  Widget buildClear() => IconButton(
    iconSize: 36,
    icon: Icon(Icons.clear, color: Colors.red),
    onPressed: () => controller.clear(),
  );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }


}