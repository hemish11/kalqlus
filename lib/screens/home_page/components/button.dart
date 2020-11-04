import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/card.dart';

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '∫ ',
                    style: GoogleFonts.lato(
                      fontSize: 110,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.kAccent,
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: GoogleFonts.lato(
                      fontSize: 60,
                      color: CustomColors.kAccent,
                      fontWeight: FontWeight.w600,
                    ),
                    child: CaTeX(r'f(x) dx'),
                  )
                ],
              )
            else
              DefaultTextStyle.merge(
                style: GoogleFonts.lato(
                  fontSize: 75,
                  color: CustomColors.kAccent,
                  fontWeight: FontWeight.w600,
                ),
                child: CaTeX(r'\frac{d}{dx}\text{ }f(x)'),
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
