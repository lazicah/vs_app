import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_app/constants.dart';
import 'package:vs_app/models/animation_models.dart';

class CardsStack extends StatelessWidget {
  final int pageNumber;
  final Widget lightCardChild;
  final Widget darkCardChild;

  const CardsStack({
    Key key,
    this.pageNumber,
    this.lightCardChild,
    this.darkCardChild,
  })  : assert(pageNumber != null),
        assert(lightCardChild != null),
        assert(darkCardChild != null);

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    var darkCardWidth = MediaQuery.of(context).size.width - 2 * kPaddingL;
    var darkCardHeight = MediaQuery.of(context).size.height / 3;
    var animationModel = Provider.of<AnimationModel>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: isOddPageNumber ? 25.0 : 50.0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: <Widget>[
          SlideTransition(
            position: animationModel.slideAnimDarkCard,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              color: kDarkBlue,
              child: Container(
                width: darkCardWidth,
                height: darkCardHeight,
                padding: EdgeInsets.only(
                  top: !isOddPageNumber ? 100.0 : 0.0,
                  bottom: isOddPageNumber ? 100.0 : 0.0,
                ),
                child: Center(
                  child: darkCardChild,
                ),
              ),
            ),
          ),
          Positioned(
            top: !isOddPageNumber ? -25.0 : null,
            bottom: isOddPageNumber ? -25.0 : null,
            child: SlideTransition(
              position: animationModel.slideAnimLightCard,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: kLightBlue,
                child: Container(
                  width: darkCardWidth * 0.8,
                  height: darkCardHeight * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: Center(
                    child: lightCardChild,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
