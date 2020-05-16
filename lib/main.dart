import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_app/models/animation_models.dart';
import 'package:vs_app/screens/onboarding/onboarding.dart';

void main() {
  runApp(ChangeNotifierProvider<AnimationModel>(
      create: (_) => AnimationModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          var screenHeight = MediaQuery.of(context).size.height;
          return Onboarding(
            screenHeight: screenHeight,
          );
        },
      ),
    );
  }
}
