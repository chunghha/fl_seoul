import 'package:mobx/mobx.dart';

// Include generated file
part 'zoom_slider.g.dart';

// This is the class used by rest of your codebase
class ZoomSlider = _ZoomSlider with _$ZoomSlider;

// The store-class
abstract class _ZoomSlider with Store {
  @observable
  double value = 12.0;

  @action
  void newvalue(newValue) {
    value = newValue;
  }

}
