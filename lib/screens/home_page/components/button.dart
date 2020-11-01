import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/screens/home_page/components/card.dart';

class Button extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const Button({Key key, @required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        size: Size(size.width * 0.85, size.height * 0.32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (text == 'Integrate')
              Text(
                '∫',
                style: GoogleFonts.lato(
                  fontSize: 140,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.kAccent,
                ),
              )
            else
              Column(
                children: [
                  Text(
                    'd',
                    style: GoogleFonts.lato(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.kAccent,
                    ),
                  ),
                  Divider(
                    color: CustomColors.kAccent,
                    thickness: 6,
                    indent: size.width * 0.32,
                    endIndent: size.width * 0.32,
                  ),
                  Text(
                    'dx',
                    style: GoogleFonts.lato(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.kAccent,
                    ),
                  ),
                ],
              ),
            Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: CustomColors.kFontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
