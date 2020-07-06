// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ag/enviroments/desa.dart';
import 'package:ag/enviroments/test.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () async {
    new Test();
    LigasServices ligasServices = new LigasServices();
    List<LigaDTO> ligas = await ligasServices.getAll();
    print(ligas.toString());

    LigaDTO liga = await ligasServices.get(ligas[0].idLiga);
    print(liga.nombre);

    LigaDTO newLiga = new LigaDTO();
    newLiga.nombre = "test 1";
    newLiga.cuit = "1566581";
    String resp = await ligasServices.save(newLiga);
    print(resp);

    resp = await ligasServices.delete(ligas[ligas.length -1].idLiga);
    print(resp);
  });
}

