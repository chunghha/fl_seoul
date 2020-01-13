import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fl_seoul/logger.dart';

// Include generated file
part 'zoom_slider.g.dart';

// This is the class used by rest of your codebase
class ZoomSlider = _ZoomSlider with _$ZoomSlider;

// The store-class
abstract class _ZoomSlider with Store, ChangeNotifier {
  @observable
  double value;

  _ZoomSlider(double initialValue) {
    value = initialValue;
    Log.d('initial zoom level: $value');
    notifyListeners();
  }

  @action
  void newvalue(newValue) {
    value = newValue;
    _save(value);
  }

  _save(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('my_zoom_level', value);
    Log.d('saved zoom level: $value');
  }
}
