import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dialog () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff003399)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            );
        }
      );
    }
    return dialog();
  }
}
