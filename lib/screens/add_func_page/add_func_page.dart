import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/models/equation.dart';
import 'package:kalqlus/screens/add_func_page/components/text_field.dart';
import 'package:kalqlus/screens/differentiate_page/differentiate_page.dart';
import 'package:kalqlus/screens/integrate_page/integrate_page.dart';

class AddFuncPage extends StatefulWidget {
  final String prevPage;

  const AddFuncPage({Key key, @required this.prevPage}) : super(key: key);

  @override
  _AddFuncPageState createState() => _AddFuncPageState();
}

class _AddFuncPageState extends State<AddFuncPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget.prevPage == 'Integrate' ? IntegratePage() : DifferentiatePage(),
          maintainState: false,
        ),
      ),
      child: Background(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomCard(
                size: Size(size.width * 0.9, size.height * 0.1),
                child: Text(
                  'KalQlus',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.kFontColor,
                  ),
                ),
              ),
              CustomTextField(
                onSubmitted: (val) => setState(() => Equation.equation = val),
              ),
              CustomCard(
                size: Size(size.width * 0.9, size.height * 0.2),
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
                        Equation.equation
                            .replaceAll('.0', '')
                            .replaceAll('^1.0', '')
                            .replaceAll('^1', '')
                            .replaceAll('*1.0', '')
                            .replaceAll('*1', '')
                            .replaceAll('1.0*', '')
                            .replaceAll('1*', '')
                            .replaceAll('+0', '')
                            .replaceAll('0+', '')
                            .replaceAll('*', ''),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.prevPage == 'Integrate' ? IntegratePage() : DifferentiatePage(),
                    maintainState: false,
                  ),
                ),
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
      ),
    );
  }
}
