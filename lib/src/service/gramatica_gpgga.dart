// ignore_for_file: avoid_print

import 'package:gpgga/src/service/coversion_codigo.dart';

class GramaticaGpgga {
  GramaticaGpgga(); //Constructor

  bool reglaUno(String codigo) {
    List<String> codigoSplit = codigo.split(",");
    bool codigo_valido = false;

    if (codigoSplit.length == 6) {
      if (codigoSplit[0] == '\$GPGGA') {
        print('Correcto');
        if (_reglaHR(codigoSplit[1])) {
          if (_reglaLTyLG(codigoSplit[2], 2)) {
            if (codigoSplit[3] == "N" || codigoSplit[3] == "S") {
              if (_reglaLTyLG(codigoSplit[4], 3)) {
                if (codigoSplit[5] == "W" || codigoSplit[5] == "E") {
                  print("Codigo GPGGA correcto");
                  final conversion = ConversionCodigo(
                      hrs: codigoSplit[1],
                      latitud: codigoSplit[2],
                      oriLa: codigoSplit[3],
                      longitud: codigoSplit[4],
                      oriLo: codigoSplit[5]);
                  codigo_valido = true;
                } else {
                  print("Dirección de longitud incorrecta");
                }
              } else {
                print('La longitud es incorrecta');
              }
            } else {
              print("Dirección de latitud incorrecta");
            }
          } else {
            print('La latitud es incorrecta');
          }
        } else {
          print("la hora es incorrecta");
        }
      }
    } else {
      print("El codigo esta incorrecto");
    }

    return codigo_valido;
  }

  bool _reglaHR(HR) {
    String H, M, S, ML;
    H = HR.substring(0, 2);
    M = HR.substring(2, 4);
    S = HR.substring(4, 6);
    ML = HR.substring(6, 9);
    bool auxH = false;

    if (((H[0] == "0" || H[0] == "1") && "0123456789".contains(H[1])) ||
        (H[0] == "2" && "01234".contains(H[1]))) {
      auxH = true;
      print('Hora correcta');
    } else {
      print('Hora incorrecta');
    }

    if (auxH && _minOseg(M) && _minOseg(S) && ML == ".00") {
      return true;
    } else {
      return false;
    }
  }

  bool _reglaLTyLG(LTG, tipo) {
    String G, M, ML2;
    bool auxG = false, auxML = true;
    G = LTG.substring(0, tipo);
    M = LTG.substring(tipo, tipo + 2);
    ML2 = LTG.substring(tipo + 3, LTG.length);

    print("LTyLG: $G - $M - $ML2");

    if (tipo == 2) {
      if (("012345678".contains(G[0]) && "0123456789".contains(G[1])) ||
          (G[0] == "9" && G[1] == "0")) {
        auxG = true;
      }
      print('Latitud: $G');
      print(LTG[2 + tipo]);
    } else {
      if ((G[0] == "0" &&
              "0123456789".contains(G[1]) &&
              "0123456789".contains(G[2])) ||
          (G[0] == "1" &&
              "01234567".contains(G[1]) &&
              "0123456789".contains(G[2])) ||
          (G[0] == "1" && G[1] == "8" && G[2] == "0")) {
        auxG = true;
      }
      print('Longitud: $G');
      print(LTG[2 + tipo]);
    }

    if (auxG) {
      print('Grados correctos');
    } else {
      print('Grados incorrectos');
    }
    for (int i = 0; i < ML2.length; i++) {
      if (!"0123456789".contains(ML2[i])) {
        auxML = false;
        print("milisegundos incorrectos");
      }
    }

    if (auxG && _minOseg(M) && LTG[2 + tipo] == "." && auxML) {
      return true;
    } else {
      print('Longitud: ${LTG[2 + tipo]}');
      return false;
    }
  }

  bool _minOseg(valor) {
    bool aux = false;
    if ("012345".contains(valor[0]) && "0123456789".contains(valor[01])) {
      print('Minuto/segundo correcto');
      aux = true;
    } else {
      print('Minuto/segundo incorrecto');
    }

    return aux;
  }
}
