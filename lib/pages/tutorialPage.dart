import 'package:flutter/material.dart';
import 'package:smart_light/widgets/measure_widget.dart';
import 'package:smart_light/widgets/tutorialCard.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({this.login});
  final Function login;
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
      ),
      body: ListView(
        children: [
          TutorialCard(
            text: "1. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "2. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "3. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "4. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "5. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "6. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "7. Como fazer sua própria medida",
          ),
          TutorialCard(
            text: "8. Como fazer sua própria medida",
          ),
          Container(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(30.0),
        child: RaisedButton(
          onPressed: () {
            widget.login();
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("Pular tutorial"),
        ),
      ),
    );
    ;
  }
}
