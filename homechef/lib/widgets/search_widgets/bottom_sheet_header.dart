import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, -3.0)
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      ),
      child: Center(
        child: Text("Add filters",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 18.0,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
