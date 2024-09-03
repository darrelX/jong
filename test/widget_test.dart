import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeExample extends StatefulWidget {
  @override
  _PinCodeExampleState createState() => _PinCodeExampleState();
}

class _PinCodeExampleState extends State<PinCodeExample> {
  TextEditingController _pinController = TextEditingController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Code Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _pinController,
              onChanged: (value) {
                setState(() {
                  _hasError = false;
                });
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              onCompleted: (value) {
                if (value.length != 4) {
                  setState(() {
                    _hasError = true;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _hasError,
              child: Text(
                "Veuillez remplir correctement le code PIN.",
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_pinController.text.length != 4) {
                  setState(() {
                    _hasError = true;
                  });
                } else {
                  setState(() {
                    _hasError = false;
                  });
                  // Faites quelque chose avec le code PIN (par exemple, une vérification)
                  print("Code PIN: ${_pinController.text}");
                }
              },
              child: Text("Vérifier"),
            ),
          ],
        ),
      ),
    );
  }
}