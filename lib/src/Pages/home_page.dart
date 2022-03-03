import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gpgga/src/service/coversion_codigo.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:gpgga/src/service/gramatica_gpgga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  String _valueText = "";

  GramaticaGpgga instanceGramtica = GramaticaGpgga();
  double sizeView = 70;
  bool viewButton = false;
  Map mapData = {};
  bool validationGpgga = false;
  int countvalidationGpgga = 0;
  String textMsj = "Gramatica GPGGA";
  late ConversionCodigo instanceConversionCode;
  double lat = 51.5;
  double lng = -0.09;
  late MapController mapController;
  String _hrData = "16:20:12";
  String _latData = "51.5";
  String _lngData = "-0.09";
  String _error = "";
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: countvalidationGpgga == 1
              ? validationGpgga
                  ? Colors.green[300]
                  : Colors.red[300]
              : Colors.amber[400],
          title: Text(textMsj),
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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 4),
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

                            if (value.isEmpty) {
                              sizeView = 70;
                              setState(() {});
                              viewButton = false;
                              countvalidationGpgga = 0;
                              textMsj = "Gramatica GPGGA";
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
                              hintText: 'Ingrese el código GPGGA'),
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
                            mapData = instanceGramtica.reglaUno(_valueText);
                            if (mapData["status"]) {
                              validationGpgga = true;
                              textMsj = "Código correcto mostrando en mapa";
                              instanceConversionCode = mapData["conversion"];

                              lat = double.parse(
                                  instanceConversionCode.getLatitud);
                              lng = double.parse(
                                  instanceConversionCode.getLongitud);
                              _latData = lat.toString();
                              _lngData = lng.toString();
                              _hrData = instanceConversionCode.gethrs;
                              _animatedMapMove(latLng.LatLng(lat, lng));
                            } else {
                              _error = mapData["error"];
                              validationGpgga = false;
                              textMsj = _error;
                            }
                            countvalidationGpgga = 1;

                            setState(() {});
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

  void _animatedMapMove(latLng.LatLng destLocation) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);

    controller.addListener(() {
      mapController.move(
          latLng.LatLng(
              _latTween.evaluate(animation), _lngTween.evaluate(animation)),
          10.0);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Widget viewMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(center: latLng.LatLng(lat, lng), zoom: 13.0),
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
              width: 170.0,
              height: 130.0,
              point: latLng.LatLng(lat, lng),
              builder: (ctx) => Container(
                  width: 800,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/8572295/pexels-photo-8572295.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [const Text("Latitud"), Text(_latData)],
                          ),
                          Column(
                            children: [const Text("Longitud"), Text(_lngData)],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [const Text("Hrs"), Text(_hrData)],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("No War")],
                      )
                    ],
                  )))
        ])
      ],
    );
  }
}
