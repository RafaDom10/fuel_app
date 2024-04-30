import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController ethanolController = TextEditingController();
  TextEditingController gasolineController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _result = 'Informe os Valores';

  void _calculateBestFuel() {
    setState(() {
      double ethanolValue =
          double.parse(ethanolController.text.replaceAll(',', '.'));
      double gasolineValue =
          double.parse(gasolineController.text.replaceAll(',', '.'));
      double percentage = ethanolValue / gasolineValue;

      _result =
          percentage <= 0.7 ? 'Abasteça com Etanol!' : 'Abasteça com Gasolina!';
    });
  }

  void _resetFields() {
    ethanolController.text = '';
    gasolineController.text = '';
    setState(() {
      _result = 'Informe os Valores';
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Etanol ou Gasolina?',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
          actions: <Widget>[
            IconButton(
                onPressed: _resetFields,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.local_gas_station,
                  size: 140.0,
                  color: Colors.lightBlue[900],
                ),
                TextFormField(
                  controller: ethanolController,
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o valor do etanol.' : null,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Valor do Etanol',
                      labelStyle: TextStyle(color: Colors.lightBlue[900])),
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                ),
                TextFormField(
                  controller: gasolineController,
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o valor da gasolina.' : null,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Valor da Gasolina',
                      labelStyle: TextStyle(color: Colors.lightBlue[900])),
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculateBestFuel();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.lightBlue[900])),
                      child: const Text(
                        'Verificar',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _result,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                )
              ],
            ),
          ),
        ));
  }
}
