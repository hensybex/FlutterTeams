import 'package:flutter/material.dart';
import 'package:black_pearl/sevices/globals.dart' as globals;

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally,
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically,

      children: [
        Text('Home'),
        Container(
          alignment: Alignment.center,
          child: Checkbox(
            checkColor: Colors.white,
            value: globals.isChecked,
            onChanged: (bool? value) {
              setState(() {
                globals.isChecked = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
