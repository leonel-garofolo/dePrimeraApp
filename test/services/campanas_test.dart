// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ag/enviroments/desa.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () async {
    new Dev();
    /*
    List<CampeonatoDTO> campeonatos;

    Provider.of<CampeonatosProvider>(context).getAll().then((value) => campeonatos = value);
    print(campeonatos.toString());

    CampeonatoDTO campeonato = await campeonatosServices.get(campeonatos[0].idCampeonato);
    print(campeonato.descripcion);

    CampeonatoDTO newCampeonato = new CampeonatoDTO();
    newCampeonato.descripcion = "Apertura 2020";
    String resp = await campeonatosServices.save(newCampeonato);
    print(resp);

    resp = await campeonatosServices.delete(campeonatos[campeonatos.length -1].idCampeonato);
    print(resp);
     */
  });
}

