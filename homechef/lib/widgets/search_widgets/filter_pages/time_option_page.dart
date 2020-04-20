import 'package:flutter/material.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/models/time_model.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/count_active_filter.dart';

class TimeOptionPage extends StatefulWidget {
  @override
  _TimeOptionPageState createState() => _TimeOptionPageState();
}

class _TimeOptionPageState extends State<TimeOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 0.2,
        spacing: 12.0,
        children: List.generate(times.length, (int index) {
          return FilterChip(
            onSelected: (value) {
              print(times[index].name);
              
              setState(() {
               timesOptions.forEach((String key, bool val) {
                  if (key != times[index].name) {timesOptions[key] = false; print(key);}
                  
                });
                timesOptions[times[index].name] = !timesOptions[times[index].name];
              });

              final notiFilterBloc = BlocProvider.of<NotiFilterBloc>(context);
              notiFilterBloc.modifyNoti(numFilters());
            },
            selected: timesOptions[times[index].name],
            selectedColor: Colors.yellow[400],
            backgroundColor: Colors.yellow[400],
            label: Text(times[index].name),
          );
        }),
      ),
    );
  }
}