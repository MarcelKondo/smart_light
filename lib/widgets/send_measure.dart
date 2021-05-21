import 'package:flutter/material.dart';

// class ProblemWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reportar um problema'),),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import '../main.dart';

class SendMeasureWidget extends StatelessWidget {
  final String imagePath;

  const SendMeasureWidget({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enviar medição'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              height: 300,
              child: FittedBox(
                clipBehavior: Clip.antiAlias,
                fit: BoxFit.fitWidth,
                child: Card(
                    //margin: const EdgeInsets.all(20),
                    borderOnForeground: true,
                    color: Colors.grey[200],
                    child: imagePath == null
                        ? Container(
                            height: 250,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Icon(Icons.report_problem_outlined),
                                  ),
                                  Center(child: Text('Ocorreu um erro'))
                                ]),
                          )
                        : Image.file(File(imagePath))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Text('Descrição do problema',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.05264214),
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis),*/
                    TextField(
                      maxLength: 5,
                      style: TextStyle(height: 1.0),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Valor medido",
                        suffix: Text("kWh"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                ModalRoute.withName("/Home"));
                          },
                          icon: Icon(Icons.send),
                          label: Text('Enviar')),
                    )
                  ]),
            )
          ],
        )
        /*Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),*/
        /*floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),*/
        );
  }
}

class SentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Informação enviada!'),
    ));
  }
}
