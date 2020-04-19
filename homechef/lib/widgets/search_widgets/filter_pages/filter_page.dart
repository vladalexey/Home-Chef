import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/cuisine_option_page.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/diet_option_page.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/excl_option_page.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/incl_option_page.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/time_option_page.dart';

class FilterPageView extends StatefulWidget {

  @override
  _FilterPageViewState createState() => _FilterPageViewState();
}

class _FilterPageViewState extends State<FilterPageView>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  Map<String, Widget> titles = {
    "Diet": new DietOptionPage(),
    "Cuisine": new CuisineOptionPage(),
    "Time": new TimeOptionPage(),
    "Exclude Ingredients": new ExclOptionPage(),
    "Include Ingredients": new InclOptionPage()
  };

  @override
  initState() {
    super.initState();

    _tabController =
        new TabController(length: titles.length, vsync: this);
  }

  List<Color> colors = [Colors.blue, Colors.red, Colors.orange, Colors.pink];
  Widget buildPageItem(int index) {
    return Container(
      color: colors[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.red[400], width: 2.0),
                  insets: EdgeInsets.symmetric(horizontal: 20.0)),
              labelColor: Colors.grey[800],
              unselectedLabelColor: Colors.grey[500],
              controller: _tabController,
              isScrollable: true,
              tabs: <Widget>[
                for (String tab in titles.keys)
                  Tab(
                    child: Text(tab,
                        maxLines: 1,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700),
                        )),
                  )
              ],
            )),
        Expanded(
            flex: 9,
            child: TabBarView(
              controller: _tabController,
              children: [
                DietOptionPage(),
                CuisineOptionPage(),
                TimeOptionPage(),
                ExclOptionPage(),
                InclOptionPage()
              ]
            )),
      ],
    );
  }
}
