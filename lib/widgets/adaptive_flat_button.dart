import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function pressedFunction;

  AdaptiveFlatButton(this.buttonText, this.pressedFunction);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(buttonText),
            onPressed: pressedFunction,
          )
        : FlatButton(
            child: Text(buttonText),
            onPressed: pressedFunction,
          );
  }
}
