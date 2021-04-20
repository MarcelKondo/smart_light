import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_light/pages/destination.dart';
//import 'package:smart_light/pages/directions.dart';

class Entrega extends StatefulWidget {
  Entrega();
  @override
  EntregaState createState() => EntregaState();
}

class EntregaState extends State<Entrega> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomInc = 1.0;
  double zoomVal = 14.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega'),
      ),
      body: Stack(
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
          (clicked_index == 0 || clicked_index == null)
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
          _buildContainer(),
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

  int clicked_index;
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        height: 195.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: _boxes(
                  -22.988804, -43.247650, 'R. Nova, 104', '0,5', '5,60', 1),
            ),
            SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: _boxes(-22.987515, -43.246309, "Estrada da Gávea, 390",
                  '0,7', '4,60', 2),
            ),
            SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: _boxes(-22.988294, -43.24796, "R. M. das Dores de Melo",
                  '1,3', '3,50', 3),
            ),
            SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: _boxes(-22.987915, -43.247435, "Estrada da Gávea 407",
                  '1,7', '5,80', 4),
            ),
            SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: _boxes(
                  -22.987658, -43.248143, "R. Dionéia", '2,6', '3,40', 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(double lat, double long, String endereco, String distancia,
      String recompensa, int index) {
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
                child: measureContainer(
                    endereco, distancia + ' km', 'R\$' + recompensa),
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
          clicked_index = 0;
        },
        markers: {
          newyork1Marker,
          newyork2Marker,
          newyork3Marker,
          gramercyMarker,
          bernardinMarker,
          blueMarker,
          myLocation
        },
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

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(-22.988804, -43.247650),
  infoWindow: InfoWindow(title: 'R. Nova, 104'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(-22.987515, -43.246309),
  infoWindow: InfoWindow(title: 'Estrada da Gávea, 390'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(-22.986493, -43.249581),
  infoWindow: InfoWindow(title: 'R. Portão Vermelho'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(-22.988294, -43.247967),
  infoWindow: InfoWindow(title: 'R. Maria das Dores de Melo 50'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(-22.987915, -43.247435),
  infoWindow: InfoWindow(title: 'Estrada da Gávea 407'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(-22.987658, -43.248143),
  infoWindow: InfoWindow(title: 'R. Dionéia 77'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker myLocation = Marker(
    markerId: MarkerId('mylocation'),
    position: LatLng(-22.987599, -43.245955),
    infoWindow: InfoWindow(title: 'Estrada da Gávea 379'),
    icon: BitmapDescriptor.defaultMarker);
