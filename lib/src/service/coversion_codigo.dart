class ConversionCodigo {
  String hrs;
  String latitud;
  String oriLa;
  String longitud;
  String oriLo;

  ConversionCodigo(
      {required this.hrs,
      required this.latitud,
      required this.oriLa,
      required this.longitud,
      required this.oriLo});

  String get gethrs {
    String hrs = this.hrs.substring(0, 2);
    String min = this.hrs.substring(2, 4);
    String seg = this.hrs.substring(4, this.hrs.length);
    return "$hrs : $min : $seg";
  }

  String get getLatitud {
    String digito1 = latitud.substring(0, 2);
    String digito2 = latitud.substring(2, latitud.length);
    double la = double.parse(digito1) + (double.parse(digito2) / 60);

    la = recortar(la, 6);

    if (oriLa == "S") {
      la = la * -1;
    }
    return la.toString();
  }

  String lat() {
    return latitud;
  }

  String lng() {
    return longitud;
  }

  String get getLongitud {
    String digito1 = longitud.substring(0, 3);
    String digito2 = longitud.substring(3, longitud.length);
    double lo = (double.parse(digito1) + (double.parse(digito2) / 60));

    lo = recortar(lo, 6);

    if (oriLo == "W") {
      lo = lo * -1;
    }

    return lo.toString();
  }

  String get getOriLa {
    return oriLa;
  }

  String get getOriLo {
    return oriLo;
  }

  double recortar(dato, cantidad) {
    double dato1 = dato;

    if (dato > 100.0) {
      cantidad += 2;
    }

    if (dato.toString().length > cantidad) {
      String aux = dato.toString().substring(0, cantidad);
      print(dato);
      dato1 = double.parse(aux);
    }

    return dato1;
  }
}
