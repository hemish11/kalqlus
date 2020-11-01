import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/background.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/screens/add_term_page/components/text_field.dart';

class AddTermPage extends StatefulWidget {
  @override
  _AddTermPageState createState() => _AddTermPageState();
}

class _AddTermPageState extends State<AddTermPage> {
  int radioVal = 0;

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
          CustomTextField(),
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
                  child: CaTeX(r'3x^2'),
                ),
              ),
            ),
          ),
          CustomCard(
            size: Size(size.width * 0.9, size.height * 0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.0,
                        child: Radio(
                          value: radioVal,
                          groupValue: 0,
                          onChanged: (val) => setState(() => radioVal = 0),
                          activeColor: CustomColors.kAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Add',
                        style: GoogleFonts.lato(
                          fontSize: 23,
                          color: CustomColors.kFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.0,
                        child: Radio(
                          value: radioVal,
                          groupValue: 1,
                          onChanged: (val) => setState(() => radioVal = 1),
                          activeColor: CustomColors.kAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Subtract',
                        style: GoogleFonts.lato(
                          fontSize: 23,
                          color: CustomColors.kFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.0,
                        child: Radio(
                          value: radioVal,
                          groupValue: 2,
                          onChanged: (val) => setState(() => radioVal = 2),
                          activeColor: CustomColors.kAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Multiply',
                        style: GoogleFonts.lato(
                          fontSize: 23,
                          color: CustomColors.kFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.0,
                        child: Radio(
                          value: radioVal,
                          groupValue: 3,
                          onChanged: (val) => setState(() => radioVal = 3),
                          activeColor: CustomColors.kAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Divide',
                        style: GoogleFonts.lato(
                          fontSize: 23,
                          color: CustomColors.kFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    );
  }
}
