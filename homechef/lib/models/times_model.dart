import 'package:homechef/models/time_model.dart';

class Times {

  void setAllFalse() {
    for (String key in timesOptions.keys) timesOptions[key] = false;
  }
}
