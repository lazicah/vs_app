import 'package:flutter/material.dart';
import 'package:vs_app/widgets/logo.dart';
import 'package:vs_app/constants.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({Key key, @required this.onSkip}) : assert(onSkip != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Hero(tag: 'logo', child: Logo(color: kWhite, size: 50.0)),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style:
                Theme.of(context).textTheme.subtitle1.copyWith(color: kWhite),
          ),
        ),
      ],
    );
  }
}
