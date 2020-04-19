import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

          StreamBuilder<int>(
            stream: BlocProvider.of<NotiFilterBloc>(context).notiStream,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData && snapshot.data != 0) {
                return Positioned(
                  right: 20.0,
                  top: 0.0,
                  child: Badge(
                    borderRadius: 1.0,
                    badgeContent: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(snapshot.data.toString(), style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );
              } else {
                return (numFilters() != 0) 
                ? Positioned(
                  right: 20.0,
                  top: 0.0,
                  child: Badge(
                    borderRadius: 1.0,
                    badgeContent: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text( numFilters().toString(), style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )
                : Container();
              }
              
            }
          ),

          Center(
            child: Text("Filters",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18.0,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
