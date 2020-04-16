import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:homechef/widgets/custom_clipper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userDiet = 'Vegan';
  
  String fallbackURL = 'https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/49203737_804075316598333_1536882256495247360_o.jpg?_nc_cat=110&_nc_sid=85a577&_nc_ohc=5ALE9dvgjUUAX9mpC34&_nc_ht=scontent.fphl2-4.fna&oh=08986e0e690c10669fca4bec9c177652&oe=5EB2E282';
  Widget avatarProfile() {

    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 5.0
                    ),
                    shape: BoxShape.circle
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(fallbackURL),
                    maxRadius: 60.0,
                    minRadius: 30.0,
                  ),
                ),

                SizedBox(height: 15.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Quan Phan',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800]
                      ),
                    )
                  ],
                ),

                SizedBox(height: 5.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                    Icon(Icons.location_on, color: Colors.grey[800],),
                    Text('Canada', style: TextStyle(color: Colors.grey[800]),),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> leadInfo = ['Nationality', 'Allergies', 'Diet'];
  List<IconData> leadIcon = [Ionicons.ios_flag, Ionicons.ios_flower, Ionicons.ios_warning];
  List<String> trailInfo = ['Vietnamese', 'None', 'Vegan'];

  List<Widget> buildProfileRow() {

      return List.generate(leadIcon.length, (index) {

        return Flexible(
          child: ListTile(
            leading: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.2,
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                  )
                ),
                
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(leadIcon[index],
                      color: Colors.grey,),
                  ),
                )
              ),
            ),
            
            title: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(leadInfo[index],), 
                  Text(trailInfo[index], style: TextStyle(fontWeight: FontWeight.w600)),
                ]
              ),
            ),

            trailing: Icon(Icons.navigate_next, color: Colors.orange,),
              
          ),
        );

      });
  }

  List<String> foodInFridge = ['Gyro', 'Hummus', 'Tomatoes', 'Spinach', 'Steak'];

  Widget fridgeAvailability() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(foodInFridge.length, (index) {

        return Flexible(
          child: ListTile(
            leading: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.2,
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                  )
                ),
                
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(Icons.ac_unit,
                      color: Colors.grey,),
                  ),
                )
              ),
            ),
            
            title: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(foodInFridge[index],), 
                ]
              ),
            ),

            trailing: Icon(Icons.navigate_next, color: Colors.orange,),
              
          ),
        );

      })
    );
  }

  Widget profileDetails() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: buildProfileRow()
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.orange,
                      Colors.amber,
                    ],
                    stops: [
                      0.0,
                      0.5
                    ])
                ),
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            
            ListView(
              children: <Widget>[
                
                avatarProfile(),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text('Profile Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),),
                  ),
                ),

                Container(
                  color: Colors.white,
                  child: profileDetails()),

                SizedBox(height: 20.0,),
                
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text('Items at home', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: fridgeAvailability()),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}