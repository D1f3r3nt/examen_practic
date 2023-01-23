import 'package:examen_practic/models/despesa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/despesa_list_provider.dart';

class Add extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey();
  Add({super.key});

  String? _titol;
  double? _quantitat;

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0, //size.width * .6,
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (text) {
                        if (text!.length == 0) {
                          return "Titol es obligatori";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 50,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Posi el titol',
                        labelText: 'Titol',
                        counterText: '',
                        icon: Icon(Icons.text_fields,
                            size: 32.0, color: Colors.blue[800]),
                      ),
                      onSaved: (text) => _titol = text,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.length == 0 || double.parse(text) < 0) {
                          return "Quantitat és obligatori";
                        }
                        return null;
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLength: 20,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Escrigui la quantitat',
                        labelText: 'Quantitat',
                        counterText: '',
                        icon: Icon(Icons.euro,
                            size: 32.0, color: Colors.blue[800]),
                      ),
                      onSaved: (text) => _quantitat = double.parse(text!),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          scanListProvider.newScan(_titol!, _quantitat!);
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        Icons.save,
                        size: 42.0,
                        color: Colors.blue[800],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
