import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: const TextField(
              decoration: InputDecoration(hintText: 'Ingrese el codigo gppga'),
            ),
          ),
          SizedBox(
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
