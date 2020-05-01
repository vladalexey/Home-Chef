import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/widgets/search_widgets/filter_pages/count_active_filter.dart';

class BottomSheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, -3.0)
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      ),
      child: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200.0,
              child: Divider(
                  color: Colors.grey[200],
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 3.0,
                ),
            ),
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(width: 40.0,),
                Icon(Ionicons.ios_options, size: 25.0, color: Colors.amber[400],),
                SizedBox(width: 10.0,),
                Text("Filters",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18.0,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )
          ),

          StreamBuilder<Map<String, dynamic>>(
            stream: BlocProvider.of<NotiFilterBloc>(context).notiStream,
            builder: (context, snapshot) {

              if (snapshot.hasData && snapshot.data['numNoti'] != 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90.0, bottom: 20.0),
                    child: Badge(
                      borderRadius: 1.0,
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(snapshot.data['numNoti'].toString(), style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                );
              } else {
                return (numFilters() != 0) 
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90.0, bottom: 20.0),
                    child: Badge(
                      borderRadius: 1.0,
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(numFilters().toString(), style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                )
                : Container();
              }
              
            }
          ),
          
        ],
      ),
    );
  }
}
