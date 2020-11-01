import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/card.dart';

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomCard(
      size: Size(size.width * 0.9, size.height * 0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter function (1 term)',
            border: InputBorder.none,
          ),
          cursorColor: CustomColors.kAccent,
          style: GoogleFonts.lato(fontSize: 25),
        ),
      ),
    );
  }
}
