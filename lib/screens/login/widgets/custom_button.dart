import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Widget image;
  final VoidCallback onPressed;

  const CustomButton(
      {Key key,
      @required this.text,
      @required this.backgroundColor,
      @required this.textColor,
      this.image,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? OutlineButton(
            onPressed: onPressed,
            color: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: kPaddingL),
                  child: image,
                ),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: textColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : FlatButton(
            color: backgroundColor,
            padding: EdgeInsets.all(kPaddingM),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: textColor, fontWeight: FontWeight.bold),
            ));
  }
}
