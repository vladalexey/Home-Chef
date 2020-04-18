import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPageView extends StatefulWidget {
  // final List<Widget> mainViews;
  final List<String> titles;
  FilterPageView(
      {
      // @required this.mainViews,
      @required this.titles});

  @override
  _FilterPageViewState createState() => _FilterPageViewState();
}

class _FilterPageViewState extends State<FilterPageView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  initState() {
    super.initState();

    _tabController =
        new TabController(length: widget.titles.length, vsync: this);
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
                for (String tab in widget.titles)
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
              children: <Widget>[
                for (int index = 0; index < widget.titles.length; index++)
                  buildPageItem(index)
              ],
            )),
      ],
    );
  }
}
