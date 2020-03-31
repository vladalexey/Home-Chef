import 'package:flutter/material.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/models/time_model.dart';
import 'package:homechef/screens/recipe_screen.dart';

class TimePage extends StatefulWidget {

  final Time time;
  TimePage({this.time});
  
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {

  bool _visible = false;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  void openSearchBar() {
    setState(() {
      _visible = true;
      });
  }

  Widget topPart() {
    return Stack(
      children: <Widget>[

        Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              )
            ],
          ),
          child: Hero(
            tag: widget.time.imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                image: AssetImage(widget.time.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                Colors.yellow[600],
              ],
              stops: [
                0.0,
                0.3,
                1.0
              ])
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 70.0
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30.0,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ), 
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => openSearchBar(),
                          ),
                          IconButton(
                            icon: Icon(Icons.sort),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      )
                    ],
                  ),

                  Visibility(
                    visible: _visible,
                    child: Center(
                    // SEARCH BAR
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)
                            ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                      spreadRadius: 3
                            )]
                        ),

                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: Colors.blue,
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(30.0),

                          child: TextField(
                            autofocus: true,
                            cursorColor: Colors.amber,
                            style: TextStyle(height: 1.2),
                            decoration: InputDecoration(
                              
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xff383838),
                              ),
                              contentPadding: EdgeInsets.only(left: 50.0, top: 0.0, bottom: 0.0),
                              hintText: 'Search recipes, cuisine, dish',
                              hintMaxLines: 1,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30.0),
                                ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 
                MediaQuery.of(context).size.width * 0.5
              ),

              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Divider(
                        height: 2.0,
                        // color: Colors.yellow[700],
                        // color: Color(0xff383838),
                        color: Colors.yellow[500],
                        thickness: 3.0,
                      ),
                    ),
                  ),
                ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
                    child: Text(
                      widget.time.name,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 10.0,
                          ),
                        ],
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff383838),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget categoryListBuilder() {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
          itemCount: widget.time.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe recipe = widget.time.recipes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipePage(
                      recipe: recipe,
                    )
                  ));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                    height: 170.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 120.0,
                                child: Text(
                                  recipe.name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${recipe.id}',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Recipe ID',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            recipe.cookTime.toString() + ' minutes',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          _buildRatingStars(recipe.rate),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    bottom: 15.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        width: 110.0,
                        image: AssetImage(
                          recipe.imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          _visible = false;
          setState(() {});
        };
      },
      child: new Scaffold(
        body: Column(
          children: <Widget>[
            
            topPart(),
            categoryListBuilder()

          ],
        )
      ),
    );
  }
}
