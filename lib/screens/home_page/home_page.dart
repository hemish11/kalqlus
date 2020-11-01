import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/screens/differentiate_page/differentiate_page.dart';
import 'package:kalqlus/screens/home_page/components/button.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/screens/integrate_page/integrate_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          CustomCard(
            size: Size(size.width * 0.85, size.height * 0.12),
            child: Text(
              'KalQlus',
              style: GoogleFonts.lato(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: CustomColors.kFontColor,
              ),
            ),
          ),
          const Spacer(),
          Button(
            text: 'Differentiate',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DifferentiatePage(),
              ),
            ),
          ),
          Button(
            text: 'Integrate',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IntegratePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
