import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPageView extends StatefulWidget {
  
  // final List<Widget> mainViews;
  final List<String> titles;
  FilterPageView({
    // @required this.mainViews, 
    @required this.titles});
  
  @override
  _FilterPageViewState createState() => _FilterPageViewState();
}

class _FilterPageViewState extends State<FilterPageView> {

  PageController _topPageController;
  PageController _mainPageController;

  @override
  initState() {
    super.initState();

    _topPageController = PageController(initialPage: 0, viewportFraction: 0.4);
    _mainPageController = PageController(initialPage: 0)
      ..addListener(_onMainScroll);
  }

  _onMainScroll() {
    _topPageController.animateTo(_mainPageController.offset * 0.4,
        duration: Duration(milliseconds: 150), curve: Curves.decelerate);
  }

  List<Color> colors = [Colors.blue, Colors.red, Colors.orange, Colors.pink];
  Widget buildPageItem(int index) {
    return Container(color: colors[index],);
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  color: Colors.white,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _topPageController,
                    itemCount: widget.titles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => _mainPageController.animateToPage(
                          index, duration: Duration(milliseconds: 150), curve: Curves.decelerate,),
                        child: Center(
                          child: AutoSizeText(
                            widget.titles[index],
                            maxLines: 1,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle( 
                                fontSize: 16.0,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700
                              ),
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: PageView.builder(
            controller: _mainPageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.titles.length,
            itemBuilder: (context, index) {
              return buildPageItem(index);
            },
          ),
        ),
      ],
    );
  }
}