import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/time_model.dart';

int numFilters() {
  int numFilter = 0;

  for (String key in cuisine_list.keys) if (cuisine_list[key]) numFilter += 1;
  for (String key in dietOptions.keys) if (dietOptions[key]) numFilter += 1;
  for (String key in timesOptions.keys) if (timesOptions[key]) numFilter += 1;

  return numFilter;
}