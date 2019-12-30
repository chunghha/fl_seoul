double getRadius(double zoomLevel) {
  var _radius = 16000.0;

  if (_between(zoomLevel, 6.0, 7.0)) {
    return 8000.0;
  }

  if (_between(zoomLevel, 7.0, 8.0)) {
    return 5000.0;
  }

  if (_between(zoomLevel, 8.0, 9.0)) {
    return 3000.0;
  }

  if (_between(zoomLevel, 9.0, 10.0)) {
    return 1600.0;
  }

  if (_between(zoomLevel, 10.0, 11.0)) {
    return 1100.0;
  }

  if (_between(zoomLevel, 11.0, 12.0)) {
    return 700.0;
  }

  if (_between(zoomLevel, 12.0, 13.0)) {
    return 450.0;
  }

  if (_between(zoomLevel, 13.0, 14.0)) {
    return 300.0;
  }

  if (_between(zoomLevel, 14.0, 15.0)) {
    return 200.0;
  }

  if (_between(zoomLevel, 15.0, 16.0)) {
    return 140.0;
  }

  if (_between(zoomLevel, 16.0, 17.0)) {
    return 90.0;
  }

  if (_between(zoomLevel, 17.0, 18.0)) {
    return 50.0;
  }

  if (_between(zoomLevel, 18.0, 19.0)) {
    return 20.0;
  }

  if (zoomLevel > 19.0) {
    return 10.0;
  }

  return _radius;
}

bool _between(double x, double v1, double v2) {
  bool isBetween = false;

  if (x > v1 && x <= v2) {
    isBetween = true;
  }

  return isBetween;
}
