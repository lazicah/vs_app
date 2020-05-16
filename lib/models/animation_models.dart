import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimationModel with ChangeNotifier {
  Animation<Offset> _slideAnimLightCard;
  Animation<Offset> _slideAnimDarkCard;
  Animation<double> _pageIndicatorAnimation;
  Animation<double> _rippleAnimation;

  Animation<Offset> get slideAnimLightCard => _slideAnimLightCard;

  setCardSlideInAnimation(AnimationController _cardsAnimController) {
    _slideAnimLightCard =
        Tween<Offset>(begin: Offset(3.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _cardsAnimController, curve: Curves.easeOut));
    _slideAnimDarkCard =
        Tween<Offset>(begin: Offset(1.5, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _cardsAnimController, curve: Curves.easeOut));
    _cardsAnimController.reset();
    notifyListeners();
  }

  setCardSlideOutAnimation(AnimationController _cardsAnimController) {
    _slideAnimLightCard =
        Tween<Offset>(end: Offset(-3.0, 0.0), begin: Offset.zero).animate(
            CurvedAnimation(
                parent: _cardsAnimController, curve: Curves.easeIn));
    _slideAnimDarkCard =
        Tween<Offset>(end: Offset(0.0, -2.0), begin: Offset.zero).animate(
            CurvedAnimation(
                parent: _cardsAnimController, curve: Curves.easeIn));
    _cardsAnimController.reset();
    notifyListeners();
  }

  setPageIndicatorAnimation(
      {bool isClockwiseAnimation = true,
      AnimationController pageIndicatorController}) {
    var multiplicator = isClockwiseAnimation ? 2 : -2;

    _pageIndicatorAnimation =
        Tween(begin: 0.0, end: multiplicator * pi).animate(CurvedAnimation(
      parent: pageIndicatorController,
      curve: Curves.easeIn,
    ));

    pageIndicatorController.reset();
    notifyListeners();
  }

  Animation<Offset> get slideAnimDarkCard => _slideAnimDarkCard;

  Animation<double> get pageIndicatorAnimation => _pageIndicatorAnimation;

  Animation<double> get rippleAnimation => _rippleAnimation;
}
