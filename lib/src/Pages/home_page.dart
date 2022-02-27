import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
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
          child: viewMap(),
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
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) => {value = _valueText},
                        decoration: const InputDecoration(
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
                          GestureDetector(
                            onTap: () {
                              instanceGramtica.reglaUno(_valueText);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn.shopify.com/s/files/1/0247/2955/0932/products/HTB1g8lziV9gSKJjSspbq6zeNXXaf_1024x1024@2x.jpg?v=1585077795")),
                                  borderRadius: BorderRadius.circular(70)),
                            ),
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

  Widget viewMap() {
    return FlutterMap(
      options: MapOptions(center: latLng.LatLng(51.5, -0.09), zoom: 13.0),
      layers: [
        TileLayerOptions(
            additionalOptions: {
              "accessToken":
                  "pk.eyJ1IjoiYnl0ZS1vemVsIiwiYSI6ImNrdzQ2YjFrajAybngyd21uZGkyZmNmcnYifQ.WVNIfs76Zw21ziiRpv4EjA",
            },
            urlTemplate:
                "https://api.mapbox.com/styles/v1/byte-ozel/ckw4fsfwc2pwc14oz01jsr9bx/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYnl0ZS1vemVsIiwiYSI6ImNrdzQ2YjFrajAybngyd21uZGkyZmNmcnYifQ.WVNIfs76Zw21ziiRpv4EjA"),
        MarkerLayerOptions(markers: [
          Marker(
              width: 70.0,
              height: 70.0,
              point: latLng.LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                            "https://i.ytimg.com/vi/2lH1hlbihRg/hqdefault.jpg"),
                      ),
                    ],
                  )))
        ])
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
