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
  double sizeView = 70;
  bool viewButton = false;

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
              height: sizeView,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 4),
                    curve: Curves.easeInCirc,
                    child: Container(
                      width: size.width * 0.8,
                      height: 60,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            _valueText = value;
                            print(value);
                            if (value.isEmpty) {
                              sizeView = 70;
                              setState(() {});
                              viewButton = false;
                              print("ningun valor ocultar button");
                            } else {
                              sizeView = 150;
                              setState(() {});
                              viewButton = true;
                            }
                          },
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: viewButton
                                      ? const BorderSide(color: Colors.grey)
                                      : const BorderSide(color: Colors.white)),
                              hintText: 'Ingrese el codigo GPGGA'),
                        ),
                      ),
                    ),
                  ),
                  viewButton
                      ? MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text("Verificar"),
                          onPressed: () {
                            instanceGramtica.reglaUno(_valueText);
                          })
                      : Container()
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
                    children: const [
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
