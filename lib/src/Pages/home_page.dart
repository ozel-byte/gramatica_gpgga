import 'package:flutter/material.dart';
import 'package:gpgga/src/service/gramatica_gpgga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _valueText = "";

  GramaticaGpgga instanceGramtica = GramaticaGpgga();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text(" Gramatica GPGGA "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _textEditingController,
              onChanged: (value) => _valueText = value,
              decoration:
                  const InputDecoration(hintText: 'Ingrese el codigo gppga'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text("Verificar"),
              onPressed: () {
                instanceGramtica.reglaUno(_valueText);
              }),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [Text("Hora"), Text("0")],
              ),
              Column(
                children: [Text("Latitud"), Text("0")],
              ),
              Column(
                children: [Text("Longitud"), Text("0")],
              )
            ],
          )
        ],
      ),
    );
  }
}
