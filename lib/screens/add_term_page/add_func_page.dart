import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/models/equation.dart';
import 'package:kalqlus/screens/add_term_page/components/text_field.dart';
import 'package:kalqlus/services/differenciation.dart';
import 'package:kalqlus/services/integration.dart';

class AddFuncPage extends StatefulWidget {
  @override
  _AddFuncPageState createState() => _AddFuncPageState();
}

class _AddFuncPageState extends State<AddFuncPage> {
  int radioVal = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
            CustomTextField(
              onSubmitted: (val) {
                Equation.equation = val;
                Equation.diffEquation = Differentiation.derivative(val);
                Equation.intEquation = Integration.integrate(val);

                print(val);
              },
            ),
            CustomCard(
              size: Size(size.width * 0.9, size.height * 0.15),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DefaultTextStyle.merge(
                    style: GoogleFonts.lato(
                      fontSize: 40,
                      color: CustomColors.kFontColor,
                    ),
                    child: CaTeX(Equation.equation),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CustomCard(
                size: Size(size.width * 0.9, size.height * 0.12),
                child: Text(
                  'Done',
                  style: GoogleFonts.lato(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.kFontColor,
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
