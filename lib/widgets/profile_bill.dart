import 'package:flutter/material.dart';
import 'package:smart_light/widgets/pdf.dart';


class ProfileBill extends StatelessWidget {
  String mes;
  String vencimento;
  String consumo;
  String dias;
  String total;
  MaterialColor color;

  ProfileBill(this.mes, this.vencimento, this.consumo, this.dias, this.total,
      this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pdf()),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              elevation: 2.5,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 22.0),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: (Text(this.mes,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 20)))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Vencimento:',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey)),
                                  Text('Consumo Total:',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey)),
                                  Text('Número de dias',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey))
                                ]),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(this.vencimento,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey)),
                                  Text(this.consumo + " kWh",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey)),
                                  Text(this.dias,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey))
                                ]),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: this.color,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "R\$" + this.total,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: this.color,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )));
  }
}
