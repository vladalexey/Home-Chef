import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/count_active_filter.dart';

class CuisineOptionPage extends StatefulWidget {
  @override
  _CuisineOptionPageState createState() => _CuisineOptionPageState();
}

class _CuisineOptionPageState extends State<CuisineOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: cuisineGroups.length,
        itemBuilder: (context, int index) {

          String groupIdx = cuisineGroups.keys.toList()[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              (index != 0) ? SizedBox(height: 15.0,) : Container(),

              Text(cuisineGroups.keys.toList()[index],
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0
                  )
                ),
              ),

              Wrap(
                runSpacing: 0.0,
                spacing: 12.0,
                children: List.generate(cuisineGroups[groupIdx].length, (int _index) {

                  List<String> currentGroupName = cuisineGroups[groupIdx];

                  String currentKey = currentGroupName[_index];

                  return FilterChip(
                    selectedColor: Colors.yellow[600],
                    onSelected: (value) {
                      setState(() {
                        cuisine_list[currentKey] = !cuisine_list[currentKey];
                      });

                      final notiFilterBloc = BlocProvider.of<NotiFilterBloc>(context);
                      final newFilterChanges = {
                        'numNoti': numFilters(),
                      };
                      notiFilterBloc.modifyNoti(newFilterChanges);
                    },
                    selected: cuisine_list[currentKey],
                    backgroundColor: Colors.yellow[600],
                    label: Text(currentKey),
                  );
                }),
              ),
            ],
          );
        }
      ),
    );
  }
}