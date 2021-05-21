import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_light/pages/destination.dart';
import 'package:http/http.dart' as http;
//import 'package:smart_light/pages/directions.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  List localizations = [];
  final url =
      "https://smart-light-ba2e9-default-rtdb.firebaseio.com/localizations.json";
  bool loading = true;
  final max_dist = 20;
  @override
  void initState() {
    super.initState();
    final myLat = -22.987599;
    final myLong = -43.245955;
    var subs = FirebaseDatabase.instance.reference().child('localizations')
      ..onChildAdded.listen((event) {
        setState(() {
          var b = event.snapshot;
          var a = b.value['data'];
          double dist =
              getDistanceFromLatLonInKm(a['lat'], a['long'], myLat, myLong);
          if (dist > max_dist) {
            return;
          }
          var list = [
            a['lat'],
            a['long'],
            a['endereco'],
            dist,
            calculateRecompensa(dist).toStringAsFixed(3),
            b.key
          ];

          print(list);
          localizations.add(list);
          localizations.sort((a, b) => a[3] > b[3] ? 1 : 0);
          loading = false;
        });
      })
      ..onChildChanged.listen((event) {
        setState(() {
          var b = event.snapshot;
          var key = b.key;
          localizations.removeWhere((element) => element[5] == key);
          var a = b.value['data'];
          double dist =
              getDistanceFromLatLonInKm(a['lat'], a['long'], myLat, myLong);
          if (dist > max_dist) {
            return;
          }
          var list = [
            a['lat'],
            a['long'],
            a['endereco'],
            dist,
            calculateRecompensa(dist).toStringAsFixed(3),
            b.key
          ];
          localizations.add(list);
        });
      })
      ..onChildRemoved.listen((event) {
        setState(() {
          var key = event.snapshot.key;
          localizations.removeWhere((element) => element[5] == key);
        });
      });
  }

  double zoomInc = 1.0;
  double zoomVal = 14.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medição'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                _buildGoogleMap(context),
                Padding(
                  padding: EdgeInsets.only(bottom: 469.0, right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      heroTag: '1',
                      mini: true,
                      backgroundColor: Colors.red[300],
                      child: Icon(Icons.my_location),
                      onPressed: () {
                        _gotoLocation(-22.987599, -43.245955);
                      },
                    ),
                  ),
                ),
                (clicked_index == '0' || clicked_index == null)
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 50, right: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            heroTag: '2',
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.navigation,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DestinationPage()),
                              );
                            },
                          ),
                        ),
                      ),
                _buildContainer(localizations),
              ],
            ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal = zoomVal - zoomInc;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal = zoomVal + zoomInc;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(-22.9890, -43.2471), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(-22.9890, -43.2471), zoom: zoomVal)));
  }

  String clicked_index;
  Widget _buildContainer(List localizations) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        height: 195.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: localizations
              .map((e) => _boxesOption(e[0], e[1], e[2], e[3], e[4], e[5]))
              .toList(),
        ),
      ),
    );
  }

  Widget _boxesOption(double lat, double long, String endereco,
      double distancia, String recompensa, String index) {
    return Container(
        child: Column(
      children: [
        SizedBox(width: 4.0),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: _boxes(lat, long, endereco, distancia, recompensa, index),
        ),
      ],
    ));
  }

  Widget _boxes(double lat, double long, String endereco, double distancia,
      String recompensa, String index) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
        setState(() {
          clicked_index = index;
        });
      },
      child: Container(
        child: Material(
            color: clicked_index == index ? Colors.amber : Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(7.0),
            shadowColor: Color(0x802196F3),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: measureContainer(endereco,
                    distancia.toStringAsFixed(3) + ' km', 'R\$' + recompensa),
              ),
            )),
      ),
    );
  }

  Widget measureContainer(
      String endereco, String distancia, String recompensa) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              distancia + '   ',
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              endereco,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          recompensa,
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

//add your lat and lng where you wants to draw polyline

  final Set<Polyline> _polyline = {};

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(-22.9890, -43.2471), zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMoveStarted: () {
            setState(() {
              clicked_index = clicked_index;
            });
          },
          onCameraIdle: () {
            clicked_index = '0';
          },
          markers: {
            ...localizations.map((e) => createMarker(e[0], e[1], e[2])).toSet(),
            Marker(
                markerId: MarkerId('mylocation'),
                position: LatLng(-22.987599, -43.245955),
                infoWindow: InfoWindow(title: 'Estrada da Gávea 379'),
                icon: BitmapDescriptor.defaultMarker),
          }
          // {
          //   newyork1Marker,
          //   newyork2Marker,
          //   newyork3Marker,
          //   gramercyMarker,
          //   bernardinMarker,
          //   blueMarker,
          //   myLocation
          // },
          ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker createMarker(double lat, double long, String title) {
  return Marker(
    markerId: MarkerId(title),
    position: LatLng(lat, long),
    infoWindow: InfoWindow(title: title),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
}

Set<Marker> setMarker(localizations) {
  Set<Marker> res =
      localizations.map((e) => createMarker(e[0], e[1], e[2])).toSet();
  Marker mylocation = Marker(
      markerId: MarkerId('mylocation'),
      position: LatLng(-22.987599, -43.245955),
      infoWindow: InfoWindow(title: 'Estrada da Gávea 379'),
      icon: BitmapDescriptor.defaultMarker);

  res.add(mylocation);
  return res.toSet();
}

// Marker gramercyMarker = Marker(
//   markerId: MarkerId('gramercy'),
//   position: LatLng(-22.988804, -43.247650),
//   infoWindow: InfoWindow(title: 'R. Nova, 104'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );

// Marker bernardinMarker = Marker(
//   markerId: MarkerId('bernardin'),
//   position: LatLng(-22.987515, -43.246309),
//   infoWindow: InfoWindow(title: 'Estrada da Gávea, 390'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker blueMarker = Marker(
//   markerId: MarkerId('bluehill'),
//   position: LatLng(-22.986493, -43.249581),
//   infoWindow: InfoWindow(title: 'R. Portão Vermelho'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );

// //New York Marker

// Marker newyork1Marker = Marker(
//   markerId: MarkerId('newyork1'),
//   position: LatLng(-22.988294, -43.247967),
//   infoWindow: InfoWindow(title: 'R. Maria das Dores de Melo 50'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker newyork2Marker = Marker(
//   markerId: MarkerId('newyork2'),
//   position: LatLng(-22.987915, -43.247435),
//   infoWindow: InfoWindow(title: 'Estrada da Gávea 407'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker newyork3Marker = Marker(
//   markerId: MarkerId('newyork3'),
//   position: LatLng(-22.987658, -43.248143),
//   infoWindow: InfoWindow(title: 'R. Dionéia 77'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );

// Marker myLocation = Marker(
//     markerId: MarkerId('mylocation'),
//     position: LatLng(-22.987599, -43.245955),
//     infoWindow: InfoWindow(title: 'Estrada da Gávea 379'),
//     icon: BitmapDescriptor.defaultMarker);

Future<List> fetchLocations(url, HomePageState a) {
  return http.get(url).then((value) {
    Map a = json.decode(value.body);
    int i = 0;
    return a.keys.toList().map((e) {
      i++;
      return [
        a[e]['data']['lat'],
        a[e]['data']['long'],
        a[e]['data']['endereco'],
        a[e]['data']['distancia'],
        a[e]['data']['Recompensa'],
        e
      ];
    }).toList();
  });
}

double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2 - lat1); // deg2rad below
  var dLon = deg2rad(lon2 - lon1);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var d = R * c; // Distance in km
  return d;
}

double deg2rad(deg) {
  return deg * (pi / 180);
}

double calculateRecompensa(dist) {
  return 0.9 * dist < 10 ? 0.9 * dist : 10;
}
