import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/components/card.dart';

class DifferentiatePage extends StatefulWidget {
  @override
  _DifferentiatePageState createState() => _DifferentiatePageState();
}

class _DifferentiatePageState extends State<DifferentiatePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomCard(
                  size: Size(size.height * 0.1, size.height * 0.1),
                  child: Transform.translate(
                    offset: Offset(5, 0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: CustomColors.kAccent,
                    ),
                  ),
                ),
              ),
              CustomCard(
                size: Size(size.width * 0.85 - size.height * 0.1 - 20, size.height * 0.1),
                child: Text(
                  'KalQlus',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: CustomCard(
              size: Size(size.width - 40, size.height * 0.1),
              child: Text(
                'Add Term',
                style: GoogleFonts.lato(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.kFontColor,
                ),
              ),
            ),
          ),
          CustomCard(
            size: Size(size.width - 40, size.height * 0.15),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Text(
                  'Input: ',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
            ),
          ),
          CustomCard(
            size: Size(size.width - 40, size.height * 0.15),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Text(
                  'Output: ',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CustomCard(
              size: Size(size.width - 40, size.height * 0.18),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Differenciate',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
