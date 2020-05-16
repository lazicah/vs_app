import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_app/models/animation_models.dart';
import 'package:vs_app/screens/login/login.dart';
import 'package:vs_app/screens/onboarding/pages/community.dart';
import 'package:vs_app/screens/onboarding/pages/education.dart';
import 'package:vs_app/screens/onboarding/pages/page.dart';
import 'package:vs_app/screens/onboarding/pages/work_pages.dart';
import 'package:vs_app/screens/onboarding/widgets/header.dart';
import 'package:vs_app/screens/onboarding/widgets/next_page.dart';
import 'package:vs_app/screens/onboarding/widgets/onboarding_indicator.dart';

import '../../constants.dart';

class Onboarding extends StatefulWidget {
  final double screenHeight;

  const Onboarding({Key key, this.screenHeight}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  AnimationController _cardsAnimController;
  AnimationController _pageIndicatorController;
  AnimationController _rippleAnimationController;
  Animation<double> _rippleAnimation;

  int _currentPage = 1;

  bool get isFirstPage => _currentPage == 1;

  Widget _getPage() {
    switch (_currentPage) {
      case 1:
        return OnboardingPage(
          number: 1,
          lightCardChild: CommunityLightCardContent(),
          darkCardChild: CommunityDarkCardContent(),
          textColumn: CommunityTextColumn(),
        );
      case 2:
        return OnboardingPage(
          number: 2,
          lightCardChild: EducationLightCardContent(),
          darkCardChild: EducationDarkCardContent(),
          textColumn: EducationTextColumn(),
        );
      case 3:
        return OnboardingPage(
          number: 3,
          lightCardChild: WorkLightCardContent(),
          darkCardChild: WorkDarkCardContent(),
          textColumn: WorkTextColumn(),
        );
      default:
        throw Exception("Page with number '$_currentPage' does not exist.");
    }
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _currentPage = nextPageNumber;
    });
  }

  void _nextPage() async {
    var animationModel = Provider.of<AnimationModel>(context, listen: false);
    switch (_currentPage) {
      case 1:
        print(animationModel.pageIndicatorAnimation.status);
        if (animationModel.pageIndicatorAnimation.status ==
            AnimationStatus.dismissed) {
          _pageIndicatorController.forward();
          await _cardsAnimController.forward();
          _setNextPage(2);
          animationModel.setCardSlideInAnimation(_cardsAnimController);
          await _cardsAnimController.forward();
        }
        animationModel.setPageIndicatorAnimation(
            isClockwiseAnimation: false,
            pageIndicatorController: _pageIndicatorController);
        break;
      case 2:
        if (animationModel.pageIndicatorAnimation.status ==
            AnimationStatus.dismissed) {
          _pageIndicatorController.forward();
          await _cardsAnimController.forward();
          _setNextPage(3);
          animationModel.setCardSlideInAnimation(_cardsAnimController);
          await _cardsAnimController.forward();
        }
        break;
      case 3:
        if (animationModel.pageIndicatorAnimation.status ==
            AnimationStatus.completed) {
          await _goToLogin();
        }
        break;
    }
  }

  Future<void> _goToLogin() async {
    await _rippleAnimationController.forward();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Login(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _cardsAnimController =
        AnimationController(vsync: this, duration: kCardAnimationDuration);

    _pageIndicatorController =
        AnimationController(vsync: this, duration: kButtonAnimationDuration);

    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: widget.screenHeight,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Onboarding oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    var animationModel = Provider.of<AnimationModel>(context, listen: false);
    animationModel.setCardSlideOutAnimation(_cardsAnimController);
    animationModel.setPageIndicatorAnimation(
        pageIndicatorController: _pageIndicatorController);
  }

  @override
  void dispose() {
    super.dispose();
    _cardsAnimController.dispose();
    _pageIndicatorController.dispose();
    _rippleAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var animationModel = Provider.of<AnimationModel>(context);

    return Scaffold(
      backgroundColor: kBlue,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kPaddingL),
              child: Column(
                children: <Widget>[
                  Header(
                    onSkip: () async {
                      await _goToLogin();
                    },
                  ),
                  Expanded(
                    child: _getPage(),
                  ),
                  AnimatedBuilder(
                    animation: animationModel.pageIndicatorAnimation,
                    child: NextPageButton(
                      onPressed: () {
                        _nextPage();
                      },
                    ),
                    builder: (_, child) {
                      return OnboardingPageIndicator(
                        currentPage: _currentPage,
                        child: child,
                        angle: animationModel.pageIndicatorAnimation.value,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rippleAnimation,
            builder: (_, child) {
              return Ripple(radius: _rippleAnimation.value);
            },
          )
        ],
      ),
    );
  }
}

class Ripple extends StatelessWidget {
  final double radius;

  const Ripple({
    @required this.radius,
  }) : assert(radius != null);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: 2 * kPaddingL - radius,
      child: Container(
        width: 2 * radius,
        height: 2 * radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kWhite,
        ),
      ),
    );
  }
}
