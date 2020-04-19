import '../widgets/flappy_search_bar-1.7.2-modified/lib/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/widgets/search_widgets/bottom_sheet.dart';
import 'package:homechef/widgets/search_widgets/bottom_sheet_header.dart';
import 'package:homechef/widgets/search_widgets/search_bar.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  
  SolidController _solidController;
  SearchBarController<Recipe> _searchController;

  void initState() {
    super.initState();
    _solidController = SolidController();
    _searchController = SearchBarController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10.0, height: 100.0,),
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: Icon(Icons.arrow_back_ios))
            ],
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: SearchBarWidget(
                searchController: _searchController,
              ),
            ),
          ),

        ],
      ),
      bottomSheet: SolidBottomSheet(
        onHide: () {
           _searchController.triggerSearch();
          },
        toggleVisibilityOnTap: false,
        maxHeight: MediaQuery.of(context).size.height * 0.65  ,
        controller: _solidController,
        draggableBody: true,
        headerBar: BottomSheetHeader(),
        body: BottomSheetBuilder()
      ),
    );
  }
}