import 'package:homechef/models/cuisine_model.dart';

class Cuisines {
  
  void setAllFalse() {
    for (String key in cuisine_list.keys) cuisine_list[key] = false;
  }
}


