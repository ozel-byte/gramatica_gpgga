// ignore_for_file: avoid_print

import 'package:gpgga/src/service/coversion_codigo.dart';
//$GPGGA,163131.00,1638.81013,N,09337.45041,W

class GramaticaGpgga {
  GramaticaGpgga(); //Constructor

  Map reglaUno(String codigo) {
    List<String> codigoSplit = codigo.split(",");
    Map<dynamic, dynamic> datosMapa = {
      'status': false,
      'conversion': 's/n',
      'error': 's/n'
    };

    final expreL = RegExp(r'^[A-z]+$');

    if (codigoSplit.length == 6) {
      if (codigoSplit[0] == '\$GPGGA' &&
          expreL.hasMatch(codigoSplit[0].substring(1, codigoSplit[0].length))) {
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
                  datosMapa = {
                    'status': true,
                    'conversion': conversion,
                    'error': 'Código correcto'
                  };
                } else {
                  print("Dirección de longitud incorrecta");
                  datosMapa = {
                    'status': false,
                    'conversion': 's/n',
                    'error': 'Direc. Long. incorrecta'
                  };
                }
              } else {
                print('La longitud es incorrecta');
                datosMapa = {
                  'status': false,
                  'conversion': 's/n',
                  'error': 'Long. incorrecta'
                };
              }
            } else {
              print("Dirección de latitud incorrecta");
              datosMapa = {
                'status': false,
                'conversion': 's/n',
                'error': 'Direc. Lati. incorrecta'
              };
            }
          } else {
            print('La latitud es incorrecta');
            datosMapa = {
              'status': false,
              'conversion': 's/n',
              'error': 'Lati. incorrecta'
            };
          }
        } else {
          print("la hora es incorrecta");
          datosMapa = {
            'status': false,
            'conversion': 's/n',
            'error': 'Hora incorrecta'
          };
        }
      } else {
        datosMapa = {
          'status': false,
          'conversion': 's/n',
          'error': 'no es \$GPGGA'
        };
      }
    } else {
      print("El codigo esta incorrecto");
      datosMapa = {
        'status': false,
        'conversion': 's/n',
        'error': 'Código incorrecto'
      };
    }

    print(datosMapa);

    return datosMapa;
  }

  bool _reglaHR(HR) {
    String H, M, S, ML;
    final numero = RegExp(r'[0-9]+$');
    final numero2 = RegExp(r'[0-3]+$');

    if (HR.length == 9) {
      H = HR.substring(0, 2);
      M = HR.substring(2, 4);
      S = HR.substring(4, 6);
      ML = HR.substring(6, 9);
      bool auxH = false;

      if (numero.hasMatch(H)) {
        if (((H[0] == "0" || H[0] == "1") && numero.hasMatch(H[1])) ||
            (H[0] == "2" && numero2.hasMatch(H[1]))) {
          auxH = true;
          print('Hora correcta');
        } else {
          print('Hora incorrecta');
        }
      }

      if (auxH && _minOseg(M) && _minOseg(S) && ML == ".00") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _reglaLTyLG(LTG, tipo) {
    String G, M, ML2;
    final numero = RegExp(r'[0-9]+$');
    final numero2 = RegExp(r'[0-8]+$');
    final numero3 = RegExp(r'[0-7]+$');

    if ((tipo == 2 && LTG.length >= 5) || (tipo == 3 && LTG.length >= 6)) {
      bool auxG = false, auxML = true, auxM = true;
      G = LTG.substring(0, tipo);
      M = LTG.substring(tipo, tipo + 2);
      ML2 = LTG.substring(tipo + 3, LTG.length);

      print(G);

      if (tipo == 2 && numero.hasMatch(G)) {
        if ((numero2.hasMatch(G[0]) && numero.hasMatch(G[1])) ||
            (G[0] == "9" && G[1] == "0")) {
          auxG = true;
          print('Latitud Correcta: $G');
        }

        print(LTG[2 + tipo]);
      } else if (numero.hasMatch(G)) {
        if ((G[0] == "0" && numero.hasMatch(G[1]) && numero.hasMatch(G[2])) ||
            (G[0] == "1" && numero3.hasMatch(G[1]) && numero.hasMatch(G[2])) ||
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

      if (!numero.hasMatch(ML2)) {
        auxML = false;
      }

      auxM = _minOseg(M);

      if (auxML && auxM) {
        if (tipo == 2 && double.parse(LTG) > 9000.0) {
          auxG = false;
          print('ConversionBien');
        } else if (tipo == 3 && double.parse(LTG) > 18000.0) {
          auxG = false;
          print('ConversionMal');
        }
      }

      if (auxG && auxM && LTG[2 + tipo] == "." && auxML) {
        print('Longitudddddddd: ${LTG[2 + tipo]}');
        return true;
      } else {
        print('LongitudErr: ${LTG[2 + tipo]}');
        return false;
      }
    } else {
      return false;
    }
  }

  bool _minOseg(valor) {
    bool aux = false;
    final numero = RegExp(r'[0-9]+$');
    final numero2 = RegExp(r'[0-5]+$');

    if (numero.hasMatch(valor)) {
      if (numero2.hasMatch(valor[0]) && numero.hasMatch(valor[1])) {
        print('Minuto/segundo correcto');
        aux = true;
      } else {
        print('Minuto/segundo incorrecto');
      }
    }

    return aux;
  }
}
