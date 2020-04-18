import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/widgets/search_widgets/bottom_sheet.dart';
import 'package:homechef/widgets/search_widgets/bottom_sheet_header.dart';
import 'package:homechef/widgets/search_widgets/cuisine_option.dart';
import 'package:homechef/widgets/search_widgets/diet_option.dart';
import 'package:homechef/widgets/search_widgets/search_bar.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class SearchScreenNew extends StatefulWidget {

  // final SearchBarController<Recipe> searchController;
  // final Function() callSearchScreenDiet, callSearchScreenCuisine;
  // SearchScreenNew({
  //   @required this.callSearchScreenDiet, 
  //   @required this.callSearchScreenCuisine,
  //   @required this.searchController
  // });

  @override
  _SearchScreenNewState createState() => _SearchScreenNewState();
}

class _SearchScreenNewState extends State<SearchScreenNew> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  SolidController _solidController;

  void initState() {
    super.initState();
     _solidController = SolidController();
    _tabController = new TabController(length: 2, vsync: this);
  }

  Future<List<String>> search(String text) async {
    List<String> apiResult = [
      'Food',
      'Recipe'
    ];
    await Future.delayed( Duration(milliseconds: 100));
    
    return apiResult;
  }
  
  

  @override
  Widget build(BuildContext context) {

    void showFilters() {
      _solidController.isOpened ? _solidController.hide() : _solidController.show();
    }


    Widget buildHeaderRow() {
      return TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child: FlatButton.icon(
              disabledTextColor: Colors.grey[700],
              onPressed: null, icon: Icon(Icons.filter_list), label: Text("Filters"),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child: FlatButton.icon(
              disabledTextColor: Colors.grey[700],
              onPressed: null, icon: Icon(Icons.person_outline), label: Text("Profile"),),
          ),
        ],
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.red[400], width: 2.0),
          insets: EdgeInsets.symmetric(horizontal: 70.0)),
        labelColor: Colors.grey[800],
        unselectedLabelColor: Colors.grey[600],
      );
    }

    Align cancelWidget = Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(30.0)
          ),
          child: Center(child: 
              IconButton(
                onPressed: () {
                  // widget.searchController.clear();
                  // FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.cancel))
            ),
        ),
      ),
    );

    Widget searchBar() {

      return SearchBar<String>(

        searchBarStyle: SearchBarStyle(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          padding: EdgeInsets.only(left: 15.0),
        ),

        icon: Icon(Icons.search),
        hintText: 'Search recipes, cuisines, diets, ...',
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),

        shrinkWrap: true,

        headerPadding: EdgeInsets.all(5.0),
        searchBarPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        // searchBarController: widget.searchController,
        
        header: buildHeaderRow(),

        cancellationWidget: cancelWidget,
        onError: (Error error) { return Text(error.toString());},
        onCancelled: () {
          print('Cancel Search');
        },

        debounceDuration: Duration(milliseconds: 1500),
        minimumChars:2,
        onSearch: search,
        onItemFound: (String name, int index) {
          return Text(name);
        },
      );
    }

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
              child: searchBar(),
            ),
          ),

        ],
      ),
      bottomSheet: SolidBottomSheet(
        controller: _solidController,
        draggableBody: true,
        headerBar: BottomSheetHeader(),
        body: BottomSheetBuilder()
      ),
    );
  }
}