import 'package:flutter/material.dart';
import 'package:kalqlus/colors.dart';

class CustomCard extends StatefulWidget {
  final Size size;
  final Widget child;

  CustomCard({Key key, @required this.size, this.child}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  GlobalKey key = GlobalKey();
  Offset pos = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _getSize() {
      setState(() {
        RenderBox box = key.currentContext.findRenderObject();

        pos = box.localToGlobal(Offset.zero);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        key: key,
        height: widget.size.height,
        width: widget.size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.lerp(
                CustomColors.kGradient1,
                CustomColors.kGradient2,
                (pos.dy) / size.height,
              ),
              Color.lerp(
                CustomColors.kGradient1,
                CustomColors.kGradient2,
                (pos.dy + widget.size.height) / size.height,
              ),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.kLight,
              offset: Offset(-10, -10),
              blurRadius: 20,
            ),
            BoxShadow(
              color: CustomColors.kDark,
              offset: Offset(10, 10),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
