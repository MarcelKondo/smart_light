import 'package:flutter/material.dart';

import 'dart:io';

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
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        maxLength: 5,
                        style: TextStyle(),
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Valor medido",
                          suffix: Text("kWh"),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      maxLength: 8,
                      style: TextStyle(),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Identificador",
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
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
