import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userDiet = 'Vegan';
  
  String fallbackURL = 'https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/49203737_804075316598333_1536882256495247360_o.jpg?_nc_cat=110&_nc_sid=85a577&_nc_ohc=5ALE9dvgjUUAX9mpC34&_nc_ht=scontent.fphl2-4.fna&oh=08986e0e690c10669fca4bec9c177652&oe=5EB2E282';
  Widget avatarProfile() {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            CircleAvatar(
              backgroundImage: NetworkImage(fallbackURL),
              maxRadius: 60.0,
              minRadius: 30.0,
            ),

            SizedBox(height: 10.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Quan Phan',
                  style: TextStyle(
                    fontSize: 40.0
                  ),
                )
              ],
            ),

            SizedBox(height: 10.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                
                Icon(Icons.location_on, color: Colors.grey,),
                Text('Canada', style: TextStyle(color: Colors.grey),),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget profileDetails() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Flexible(
          child: ListTile(
            leading: Icon(Ionicons.ios_alert),
            title: Text('Diet Restriction: $userDiet'),
            // subtitle: Text('Vegan'),
          ),
        )

      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Expanded(
            //   child: ,),
            
            ListView(
              children: <Widget>[
                
                avatarProfile(),

                profileDetails(),

              ],
            ),
          ],
        ),
      ),
    );
  }
}