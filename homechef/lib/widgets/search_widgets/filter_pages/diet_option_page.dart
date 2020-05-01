import 'package:flutter/material.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/diets_model.dart';
import 'package:homechef/models/search_profile_model.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/count_active_filter.dart';

class DietOptionPage extends StatefulWidget {
  @override
  _DietOptionPageState createState() => _DietOptionPageState();
}

class _DietOptionPageState extends State<DietOptionPage> {
  @override
  Widget build(BuildContext context) {

    final Diets dietsController = Diets();
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder<Map<String, dynamic>>(
        stream: BlocProvider.of<NotiFilterBloc>(context).notiStream,
        initialData: {'numNoti': 0, 'saveProfileSelect': false},
        builder: (context, snapshot) {

          return Wrap(
            runSpacing: 0.2,
            spacing: 12.0,
            children: List.generate(diets.length, (int index) {
              return FilterChip(
                onSelected: (value) {
                  
                  setState(() {
                    dietsController.setAllFalseExcept(diets[index]);
                  });
                  
                  final notiFilterBloc = BlocProvider.of<NotiFilterBloc>(context);
                  final newFilterChanges = {
                    'numNoti': numFilters(),
                    'saveProfileSelect': (dietOptions[encodeDietName(SearchProfile().getSaveDiet)]) ? true : false
                  };
                  notiFilterBloc.modifyNoti(newFilterChanges);

                },
                selectedColor: Colors.amber[400],
                selected: dietOptions[encodeDietName(diets[index].name)],
                backgroundColor: Colors.amber[400],
                label: Text(diets[index].name),
              );
            }),
          );
      }),
    );
  }
}