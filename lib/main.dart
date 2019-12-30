import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import 'package:fl_seoul/store/zoom_slider.dart';
import 'package:fl_seoul/util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ZoomSlider>(
        create: (_) => ZoomSlider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Map Demo',
            home: Consumer<ZoomSlider>(
              builder: (context, zoomSLider, _) {
                return CirclePage();
              },
            )));
  }
}

class CirclePage extends StatefulWidget {
  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  static final double _latitude = 37.5665;
  static final double _longitude = 126.9780;

  MapController _mapController;
  LatLng _center;

  @override
  void initState() {
    super.initState();

    _mapController = MapController();
    _center = LatLng(_latitude, _longitude);
  }

  @override
  Widget build(BuildContext context) {
    final ZoomSlider zoomSlider = Provider.of<ZoomSlider>(context);

    var circleMarkers = <CircleMarker>[
      CircleMarker(
          point: LatLng(_latitude, _longitude),
          color: '#bf616a'.toColor().withOpacity(0.7),
          borderColor: '#ebcb8b'.toColor(),
          borderStrokeWidth: 3,
          useRadiusInMeter: true,
          radius: getRadius(zoomSlider.value) // 200 meters | 0.2 km
          ),
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: '#2e3440'.toColor(),
          elevation: 16.0,
          title: Text('Seoul',
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: '#eceff4'.toColor(),
                      fontWeight: FontWeight.w700)))),
      backgroundColor: '#2e3440'.toColor(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 32.0),
        child: Stack(children: <Widget>[
          Column(children: [
            Observer(
                builder: (_) => Flexible(
                      child: FlutterMap(
                        options: MapOptions(
                          center: _center,
                          zoom: zoomSlider.value,
                        ),
                        layers: [
                          TileLayerOptions(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c']),
                          CircleLayerOptions(circles: circleMarkers)
                        ],
                        mapController: _mapController,
                      ),
                    ))
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                    color: '#2e3440'.toColor().withOpacity(0.75),
                    elevation: 16.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {},
                    child: Slider(
                      activeColor: '#88c0d0'.toColor(),
                      inactiveColor: '#d8dee9'.toColor(),
                      min: 5.0,
                      max: 19.0,
                      divisions: 14,
                      label: zoomSlider.value.toString(),
                      onChanged: (sliderValue) {
                        setState(() {
                          zoomSlider.newvalue(sliderValue);
                          _mapController.move(_center, zoomSlider.value);
                        });
                      },
                      value: zoomSlider.value,
                    )),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
