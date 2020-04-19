import 'package:flutter/material.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/count_active_filter.dart';

class DietOptionPage extends StatefulWidget {
  @override
  _DietOptionPageState createState() => _DietOptionPageState();
}

class _DietOptionPageState extends State<DietOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 0.2,
        spacing: 12.0,
        children: List.generate(diets.length, (int index) {
          return FilterChip(
            onSelected: (value) {

              setState(() {

                dietOptions.forEach((String key, bool val) {
                  if (key != encodeDietName(diets[index].name)) dietOptions[key] = false;
                });
                dietOptions[encodeDietName(diets[index].name)] = !dietOptions[encodeDietName(diets[index].name)];
              });

              final notiFilterBloc = BlocProvider.of<NotiFilterBloc>(context);
              notiFilterBloc.modifyNoti(numFilters());
            },
            selectedColor: Colors.amber[400],
            selected: dietOptions[encodeDietName(diets[index].name)],
            backgroundColor: Colors.amber[400],
            label: Text(diets[index].name),
          );
        }),
      ),
    );
  }
}