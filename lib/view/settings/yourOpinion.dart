
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/comentariosProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/component/fieldArea.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class YourOpinion extends StatefulWidget {
  YourOpinion({Key key}) : super(key: key);

  @override
  _YourOpinionState createState() => _YourOpinionState();
}

class _YourOpinionState extends State<YourOpinion> {
  final email = TextEditingController();
  final opinion = TextEditingController();
  double puntaje = 3;

  @override
  void initState() {
    super.initState();
    Provider.of<SharedPreferencesProvider>(context, listen: false).getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    email.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserId();
    print("AAAAASSS" + email.text);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tu Opinion"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FieldText(
              controller: email,
              label: "Email",
            ),
            SizedBox(height: 30,),
            Text("Puntaje"),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                this.puntaje = rating;
                print(rating);
              },
            ),
            SizedBox(height: 30,),
            FieldArea(
              controller: opinion,
              label: "Ingrese su opinion",
              rows: 3,
            ),
            SizedBox(height: 30,),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  send(context);
                },
                child: Text("Enviar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18).copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  send(BuildContext context){
    ComentariosDTO dto = new ComentariosDTO(
      mail: email.text,
      puntaje: this.puntaje,
      comentario: opinion.text
    );
    Provider.of<ComentariosProvider>(context, listen: false).save(dto).then((value) {
      print(value);
      Navigator.pop(context);
    });
  }
}