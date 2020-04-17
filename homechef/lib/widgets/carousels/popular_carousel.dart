import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/models/popular_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:homechef/widgets/rating_stars.dart';

class PopularCarouselPage extends StatefulWidget {

  @override
  _PopularCarouselPageState createState() => _PopularCarouselPageState();
}

class _PopularCarouselPageState extends State<PopularCarouselPage> {

  int currentPage = 0;
  PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: currentPage, viewportFraction: 0.9);
  }

  GestureDetector _buildPage(double height, int index) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipePage(
              recipe: populars[index],
            )
          ));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: <Widget>[

                  Positioned(
                    top: 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: height * 1.1,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            color: Colors.grey[300]
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Stack(
                            children: <Widget>[

                              ConstrainedBox(
                                constraints: BoxConstraints.expand(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: height * 0.85,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      populars[index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              ConstrainedBox(
                                constraints: BoxConstraints.expand(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: height * 0.85,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: height * 0.85,
                                    // width: MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.9),
                                        ],
                                        stops: [
                                          0.3,
                                          1.0
                                        ])
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 0.0),
                              child: Text(
                                populars[index].name,
                                // maxFontSize: 22,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  color: Colors.grey[900],
                                  letterSpacing: 0.2
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 3.0, right: 10.0),
                              child: RatingStars(rating: populars[index].rate, color: Colors.grey[700],)
                            )
                          )
                          
                        ],
                      ),
                    ),
                  ),

                  
                  
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: 
                  // ),
                      
                  // Positioned(
                  //   top: 10.0,
                  //   child: 
                  // ),

                  
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void getChangedPage(int index) {
    currentPage = index;
    setState(() {});
  }

  Widget circleBar(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 4),
    height: isActive ? 7 : 6,
    width: isActive ? 7 : 6,
    decoration: BoxDecoration(
        color: isActive ? Colors.grey[600] : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey[600])),
  );
}

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.width * 0.55;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Container(
          height: height * 1.25,
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _buildPage(height, index);
            },
            onPageChanged: (int index) {
              getChangedPage(index);
            },
            itemCount: populars.length,
            controller: controller,
          )
        ),

        SizedBox(height: 5.0,),

        SizedBox(
          height: 10.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              for (int i = 0; i < populars.length; i++)
                if (i == currentPage) ...[circleBar(true)] else
                  circleBar(false),
                  
            ],
          ),
        ),

        SizedBox(height: 10.0,)
      ],
    );
  }
}