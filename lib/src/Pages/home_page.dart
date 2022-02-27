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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: const Text(" Gramatica GPGGA "),
        ),
        body: map(size));
  }

  Widget map(Size size) {
    return Stack(
      children: [
        Container(
          color: Colors.blue,
          width: size.width * 1,
          height: size.height * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: size.width * 0.9,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: 'Ingrese el codigo GPGGA'),
                      ),
                    ),
                  ),
                  Container(
                      width: size.width * 0.2,
                      height: size.height * 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://th.bing.com/th/id/OIP.BP2du1B99ZGqAaC-N7ABcAHaE7?w=264&h=180&c=7&r=0&o=5&pid=1.7")),
                                borderRadius: BorderRadius.circular(70)),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)))
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget list() {
    return ListView(
      children: [
        Column(
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
      ],
    );
  }
}
