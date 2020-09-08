import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({@required this.onPressed, @required this.text, this.style, this.elevation, this.color, this.textColor, this.borderColor, this.borderWidth:0.0});
  final double elevation;
  final Function onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
//      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.06,
      child: RaisedButton(
        elevation: elevation,
        onPressed: onPressed,
        child: Text(text,
            style: style ??
              TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sansation'
              ),
        ),
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(
            width: borderWidth,
            color: borderColor ?? color,
          ),
        ),
      ),
    );
  }
}

