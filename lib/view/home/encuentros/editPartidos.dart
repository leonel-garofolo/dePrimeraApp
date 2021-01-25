

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/fieldCheckBox.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class EditPartidos extends StatefulWidget{
  final PartidosFromDateDTO partidosFromDateDTO;
  EditPartidos({this.partidosFromDateDTO});

  @override
  State<StatefulWidget> createState() => EditPartidosState();

}

class EditPartidosState extends State<EditPartidos>{
  final _formKey = GlobalKey<FormState>();

  final golesLocal = TextEditingController();
  final goleadoresLocal = TextEditingController();
  final amarillasLocal = TextEditingController();
  final rojasLocal = TextEditingController();
  final golesVisitante = TextEditingController();
  final goleadoresVisitante = TextEditingController();
  final amarillasVisitante = TextEditingController();
  final rojasVisitante = TextEditingController();
  final motivo = TextEditingController();
  bool partidoIniciado = false;
  bool partidoFinalizado = false;
  bool partidoSuspendido = false;

  @override
  Widget build(BuildContext context) {
    golesLocal.text = this.widget.partidosFromDateDTO.resultadoLocal.toString();
    golesVisitante.text = this.widget.partidosFromDateDTO.resultadoVisitante.toString();
    partidoIniciado = this.widget.partidosFromDateDTO.iniciado;
    partidoFinalizado = this.widget.partidosFromDateDTO.finalizado;
    partidoSuspendido= this.widget.partidosFromDateDTO.suspendido;
    motivo.text = this.widget.partidosFromDateDTO.motivo;
    Widget divider = Divider(
      color: Colors.black,
      height: 20,
      thickness: 1,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Encuentro"),
        leading: BackButton(
            onPressed: (){
              Navigator.pop(context, false);
            },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Equipo Local", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(this.widget.partidosFromDateDTO.eLocalName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              FieldText(
                label: "Goles de Local",
                controller: golesLocal,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Goleadores Local: " + this.goleadoresLocal.text),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: (){
                          print("agrego");
                          editGoleadores(0);
                        }
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Sanciones Local", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amarillas: " + this.amarillasLocal.text),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                print("agrego");
                                editSanciones(0,0);
                              }
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rojas: " + this.rojasLocal.text),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                editSanciones(0, 1);
                              }
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider,
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text("Equipo Visitante", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(this.widget.partidosFromDateDTO.eVisitName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              FieldText(
                label: "Goles de Visitantes",
                controller: golesVisitante,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Goleadores Visitante: " + this.goleadoresVisitante.text),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: (){
                          editGoleadores(1);
                        }
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Sanciones Visitante", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amarillas: " + this.amarillasVisitante.text),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                editSanciones(1,0);
                              }
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rojas: " + this.rojasVisitante.text),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                editSanciones(1,1);
                              }
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider,
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text("Estado del Partido", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              ),
              FieldCheckbox(
                label: "Partido Iniciado",
                value: this.partidoIniciado,
                valueChanged: (newValue){
                  setState(() {
                    this.widget.partidosFromDateDTO.iniciado = newValue;
                  });
                },
              ),
              FieldCheckbox(
                label: "Partido Finalizado",
                value: this.partidoFinalizado,
                valueChanged: (newValue){
                  setState(() {
                    this.widget.partidosFromDateDTO.finalizado = newValue;
                  });
                },
              ),
              FieldCheckbox(
                label: "Partido Suspendido",
                value: this.partidoSuspendido,
                valueChanged: (newValue){
                  setState(() {
                    this.widget.partidosFromDateDTO.suspendido = newValue;
                  });
                },
              ),
              FieldText(
                label: "Motivo",
                controller: motivo,
              ),

              Container(height: 10,),
              ButtonRequest(
                  text: "Guardar",
                  onPressed: (){
                    save();
                  }
              ),
            ],
          ),
        ),),
    );
  }

  void save() {
    PartidoResultDTO dto = new PartidoResultDTO(
      idPartidos: this.widget.partidosFromDateDTO.idPartidos,
      resultadoLocal: int.parse(this.golesLocal.text),
      goleadoresLocal: this.goleadoresLocal.text,
      sancionAmarillosLocal: this.amarillasLocal.text,
      sancionRojosLocal: this.rojasLocal.text,
      resultadoVisitante: int.parse(this.golesVisitante.text),
      goleadoresVisitante: this.goleadoresVisitante.text,
      sancionAmarillosVisitante: this.amarillasVisitante.text,
      sancionRojosVisitante: this.rojasVisitante.text,
      iniciado: this.partidoIniciado,
      finalizado: this.partidoFinalizado,
      suspendido: this.partidoSuspendido,
      motivo: this.motivo.text
    );
    Provider.of<PartidosProvider>(context, listen: false).saveStatePartido(dto).then((value){
      print("insertado? " + value.toString());
      Navigator.pop(context, value);
    });
  }

  /* equipo
  * 0 - Local
  * 1- Visitante
  *
  * colorTarjeta
  * 0- Amarillas
  * 1- Rojas
   */
  editSanciones(int equipo, int colorTarjeta) async{
    String title = "";

    String subTitle = "Sanciones ";
    switch(colorTarjeta){
      case 0:
        subTitle += "Amarillas";
        break;
      case 1:
        subTitle += "Rojas";
        break;
    }

    switch(equipo){
      case 0:
        title += this.widget.partidosFromDateDTO.eLocalName;
        break;
      case 1:
        title += this.widget.partidosFromDateDTO.eVisitName;
        break;
    }

    final nroCamiseta = TextEditingController();
    switch(equipo){
      case 0:
        switch(colorTarjeta){
          case 0:
            nroCamiseta.text = this.amarillasLocal.text;
            break;
          case 1:
            nroCamiseta.text = this.rojasLocal.text;
            break;
        }
        break;
      case 1:
        switch(colorTarjeta){
          case 0:
            nroCamiseta.text = this.amarillasVisitante.text;
            break;
          case 1:
            nroCamiseta.text = this.rojasVisitante.text ;
            break;
        }
        break;
    }



    String nroCamisetasResult = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            height: 300.0,
            width: 400.0,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: FieldText(
                    label: "Numeros de Camisetas",
                    hint: "Numeros separados por espacio",
                    controller: nroCamiseta,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: ButtonRequest(
                      text: "Aplicar",
                      onPressed: (){
                        Navigator.pop(context, nroCamiseta.text);
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    print(nroCamisetasResult);
    setState(() {
      switch(equipo){
        case 0:
          switch(colorTarjeta){
            case 0:
              this.amarillasLocal.text = nroCamisetasResult;
              break;
            case 1:
              this.rojasLocal.text = nroCamisetasResult;
              break;
          }
          break;
        case 1:
          switch(colorTarjeta){
            case 0:
              this.amarillasVisitante.text = nroCamisetasResult;
              break;
            case 1:
              this.rojasVisitante.text = nroCamisetasResult;
              break;
          }
          break;
      }
    });
  }

  /* equipo
  * 0 - Local
  * 1- Visitante
   */
  editGoleadores(int equipo) async{
    final goleadores = TextEditingController();
    String title = "";

    String subTitle = "Goleadores ";
    switch(equipo){
      case 0:
        title += this.widget.partidosFromDateDTO.eLocalName;
        goleadores.text = this.amarillasLocal.text;
        break;
      case 1:
        title += this.widget.partidosFromDateDTO.eVisitName;
        break;
    }

    String goleadoresResult = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            height: 300.0,
            width: 400.0,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: FieldText(
                    label: "Numeros de Camisetas",
                    hint: "Numeros separados por espacio",
                    controller: goleadores,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: ButtonRequest(
                      text: "Aplicar",
                      onPressed: (){
                        Navigator.pop(context, goleadores.text);
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    print(goleadoresResult);
    setState(() {
      switch(equipo){
        case 0:
          this.goleadoresLocal.text = goleadoresResult;
          break;
        case 1:
          this.goleadoresVisitante.text = goleadoresResult;
          break;
      }
    });

  }
}

