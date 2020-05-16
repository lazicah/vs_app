import 'package:flutter/material.dart';
import 'package:vs_app/constants.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({Key key, this.title, this.text})
      : assert(title != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: kWhite, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kSpaceS,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: kWhite),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
