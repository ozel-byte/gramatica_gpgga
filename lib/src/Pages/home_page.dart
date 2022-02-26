import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Holaaa"),
      ),
      body: Column(
        children: [
          Container(
            child: const TextField(
              decoration: InputDecoration(hintText: 'Ingrese el codigo gppga'),
            ),
          ),
          Row(
            children: [
              Column(
                children: [Text("Hora"), Text("0")],
              ),
              Column(
                children: [Text("Latitud"), Text(" ")],
              ),
              Column(
                children: [Text("Longitud"), Text("")],
              )
            ],
          )
        ],
      ),
    );
  }
}
