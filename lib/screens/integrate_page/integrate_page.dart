import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/models/equation.dart';
import 'package:kalqlus/screens/add_func_page/add_func_page.dart';
import 'package:kalqlus/screens/home_page/home_page.dart';

class IntegratePage extends StatefulWidget {
  @override
  _IntegratePageState createState() => _IntegratePageState();
}

class _IntegratePageState extends State<IntegratePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
          maintainState: false,
        ),
      ),
      child: Background(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                      maintainState: false,
                    ),
                  ),
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
                  size: Size(size.width * 0.85 - size.height * 0.1 - 30, size.height * 0.1),
                  child: Text(
                    'KalQlus',
                    style: GoogleFonts.lato(
                      fontSize: 37,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.kFontColor,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFuncPage(prevPage: 'Integrate'),
                  maintainState: false,
                ),
              ),
              child: CustomCard(
                size: Size(size.width - 40, size.height * 0.1),
                child: Text(
                  Equation.equation == '' ? 'Add function' : 'Edit function',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
            ),
            CustomCard(
              size: Size(size.width - 40, size.height * 0.2),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: DefaultTextStyle.merge(
                    style: GoogleFonts.lato(
                      fontSize: 40,
                      color: CustomColors.kFontColor,
                    ),
                    child: CaTeX(r'\text{Input: }∫\text{ }(' + Equation.toLatex(Equation.equation) + ')dx'),
                  ),
                ),
              ),
            ),
            CustomCard(
              size: Size(size.width - 40, size.height * 0.2),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: DefaultTextStyle.merge(
                    style: GoogleFonts.lato(
                      fontSize: 40,
                      color: CustomColors.kFontColor,
                    ),
                    child: CaTeX(
                      r'\text{Output: }' + Equation.toLatex(Equation.intEquation).replaceAll('*', '') + '+c',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
