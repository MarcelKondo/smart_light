import 'package:flutter/material.dart';

class ProfileBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      ListView(
      children: [
        Card(
            child: Column(
          children: [
            Text('Abril',style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Column(children: [
                  Text('Vencimento:'),
                  Text('Consumo Total Fatural:'),
                  Text('djvhbdjbsd')
                ]),
                Column(
                  children: [],
                )
              ],
            ),
          ],
        ))
      ],
    ));
  }
}
