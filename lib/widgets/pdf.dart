import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';

class Pdf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conta de Fevereiro'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Compartilhar',
          onPressed: () {
            Share.share('ola');
          },
        )
      ]),
      body: Container(
        child: Image.asset('images/elektro.png'),
      ),
    );
  }
}
