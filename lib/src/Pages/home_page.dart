import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
