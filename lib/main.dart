import 'dart:async';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:supercharged/supercharged.dart';

import 'package:fl_seoul/logger.dart';
import 'package:fl_seoul/store/zoom_slider.dart';
import 'package:fl_seoul/util.dart';
import 'package:fl_seoul/widgets/dongdaemoon_widget.dart';
import 'package:fl_seoul/widgets/lotte_widget.dart';
import 'package:fl_seoul/widgets/seoul_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  static SharedPreferences _prefs;

  MyApp(SharedPreferences prefs) {
    _prefs = prefs;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ZoomSlider>(
        create: (_) {
          final initialValue = _prefs.getDouble('my_zoom_level') ?? 12.0;
          return ZoomSlider(initialValue);
        },
        child: OverlaySupport(
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Map Demo',
                home: Consumer<ZoomSlider>(builder: (context, zoomSlider, _) {
                  return CirclePage();
                }))));
  }
}

class CirclePage extends StatefulWidget {
  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> with TickerProviderStateMixin {
  int _tabIndex;
  MapController _mapController;
  LatLng _center;
  CircleMarker _marker;
  List<LatLng> locations = [
    LatLng(37.5665, 126.9780), // Seoul City Hall
    LatLng(37.511234, 127.098030), // Lotte Tower
    LatLng(37.5704, 127.0078) // Dongdaemoon Market
  ];
  PanelController _panelController;

  @override
  void initState() {
    super.initState();

    _tabIndex = 0;
    _mapController = MapController();
    _center = locations[_tabIndex];
    _panelController = PanelController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ZoomSlider zoomSlider =
        Provider.of<ZoomSlider>(context, listen: false);

    var _radius = getRadius(zoomSlider.value);

    List<CircleMarker> circleMarkers = locations
        .asMap()
        .entries
        .map((entry) => CircleMarker(
            point: locations[entry.key],
            color: '#bf616a'.toColor().withOpacity(0.7),
            borderColor: '#ebcb8b'.toColor(),
            borderStrokeWidth: 3,
            useRadiusInMeter: true,
            radius: _radius))
        .toList();

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
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 500),
          backgroundColor: '#c8ced9'.toColor(),
          buttonBackgroundColor: '#eceff4'.toColor(),
          color: '#e5e9f0'.toColor().withOpacity(0.7),
          items: <Widget>[
            Icon(Icons.trip_origin, size: 30),
            Icon(Icons.local_see, size: 30),
            Icon(Icons.local_mall, size: 30),
          ],
          onTap: (index) {
            LatLng location;
            int markerIndex;
            switch (index) {
              case 0:
              case 1:
              case 2:
                location = locations[index];
                markerIndex = index;
                _tabIndex = index;
                break;
              default:
                location = locations[0];
                markerIndex = 0;
                _tabIndex = 0;
                break;
            }
            setState(() {
              _marker = circleMarkers[markerIndex];
              _center = location;
              _radius = getRadius(zoomSlider.value);
              _animatedMapMove(_center, zoomSlider.value);
              Log.d('Tab Index is now $_tabIndex.');
            });
          },
        ),
        body: GestureDetector(
            onTap: () async {
              setState(() {
                _panelController.isPanelClosed()
                    ? _panelController.open()
                    : _panelController.close();
              });
              // wait for the panel state updated
              await new Future.delayed(const Duration(seconds: 1));
              _panelController.isPanelClosed()
                  ? Log.d('Panel closed on the tap.')
                  : Log.d('Panel opened on the tap.');
            },
            child: SlidingUpPanel(
                controller: _panelController,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: '#d8dee9'.toColor().withOpacity(0.35),
                minHeight: 84.0,
                maxHeight: 532.0,
                parallaxEnabled: true,
                parallaxOffset: 0.7,
                slideDirection: SlideDirection.UP,
                panel: _getSlidingUpWidget(_tabIndex),
                body: Consumer<ZoomSlider>(builder: (context, zoomSLider, _) {
                  return Padding(
                    padding: EdgeInsets.all(12.0),
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
                                      CircleLayerOptions(
                                          circles: _marker != null
                                              ? <CircleMarker>[_marker]
                                              : <CircleMarker>[
                                                  circleMarkers[0]
                                                ])
                                    ],
                                    mapController: _mapController,
                                  ),
                                ))
                      ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 8.0),
                            child: RaisedButton(
                                color: '#5e81ac'.toColor().withOpacity(0.55),
                                elevation: 16.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
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
                                      _radius = getRadius(zoomSlider.value);
                                      _animatedMapMove(
                                          _center, zoomSlider.value);
                                      showSimpleNotification(
                                          Text('Zoom Level set to $sliderValue',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          leading: Icon(
                                            Icons.info_outline,
                                            size: 32.0,
                                          ),
                                          background: '#a3be8c'.toColor(),
                                          foreground: '#2e3440'.toColor(),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              32.0, 4.0, 4.0, 8.0));
                                    });
                                  },
                                  value: zoomSlider.value,
                                )),
                          )
                        ],
                      ),
                    ]),
                  );
                }))));
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 650), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  StatelessWidget _getSlidingUpWidget(int index) {
    switch (index) {
      case 0:
        return SeoulWidget();
      case 1:
        return LotteWidget();
      case 2:
        return DongdaemmonWidget();
      default:
        return SeoulWidget();
    }
  }
}
