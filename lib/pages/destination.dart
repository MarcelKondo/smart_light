import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_light/widgets/camera_measure.dart';
import '../widgets/camera_measure.dart';
import 'package:camera/camera.dart';
//import 'package:smart_light/pages/directions.dart';

class DestinationPage extends StatefulWidget {
    
  @override
  DestinationPageState createState() => DestinationPageState();
}

class DestinationPageState extends State<DestinationPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    List<LatLng> latlng = List();
                        LatLng _new = LatLng(-22.987599, -43.245955);
                        LatLng _news = LatLng(-22.988294, -43.247967);

                        latlng.add(_new);
                        latlng.add(_news);

                        _polyline.add(Polyline(
                          polylineId: PolylineId('1'),
                          visible: true,
                          //latlng is List<LatLng>
                          points: latlng,
                          color: Colors.blue,
                        ));
    super.initState();
  }
  

  double zoomInc = 1.0;
  double zoomVal = 14.0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medição'),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          Padding(
            padding: EdgeInsets.only(top: 505.0, right: 11.5),
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton.extended(
                heroTag: '1',
                backgroundColor: Colors.red[300],
                label: Text('Medir'),
                icon: Icon(Icons.explore),
                onPressed: () async {

                final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
                  final firstCamera = cameras.first;
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TakePictureScreen(firstCamera)),
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

  int clicked_index;
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        height: 195.0,
        child: Container()
      ),
    );
  }


//add your lat and lng where you wants to draw polyline

  final Set<Polyline> _polyline = {};

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        polylines: _polyline,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(-22.9890, -43.2471), zoom: 17),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
           
        },
        markers: {
          myLocation, 
          newyork1Marker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 18.5,
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
