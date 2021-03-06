import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalqlus/colors.dart';
import 'package:kalqlus/components/card.dart';
import 'package:kalqlus/models/equation.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  const CustomTextField({Key key, this.onSubmitted}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController(text: Equation.equation);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomCard(
      size: Size(size.width * 0.9, size.height * 0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter function',
            border: InputBorder.none,
          ),
          cursorColor: CustomColors.kAccent,
          style: GoogleFonts.lato(fontSize: 25),
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
