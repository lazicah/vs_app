import 'package:flutter/material.dart';
import 'package:vs_app/constants.dart';
import 'package:vs_app/screens/login/widgets/blue_top_clipper.dart';
import 'package:vs_app/screens/login/widgets/custom_button.dart';
import 'package:vs_app/screens/login/widgets/grey_top_clipper.dart';
import 'package:vs_app/screens/login/widgets/header.dart';
import 'package:vs_app/screens/login/widgets/white_top_cliper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: GreyTopClipper(),
            child: Container(
              color: kGrey,
            ),
          ),
          ClipPath(
            clipper: BlueTopClipper(),
            child: Container(
              color: kBlue,
            ),
          ),
          ClipPath(
            clipper: WhiteTopClipper(),
            child: Container(
              color: kWhite,
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingL),
            child: Column(
              children: <Widget>[
                Flexible(child: Header()),
                Spacer(),
                LoginForm(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextField(
              label: 'Username or Email',
              prefixIcon: Icons.person,
              obscureText: false,
            ),
            SizedBox(
              height: space,
            ),
            CustomTextField(
              label: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(
              height: space,
            ),
            CustomButton(
              backgroundColor: kBlue,
              textColor: kWhite,
              text: 'Login to continue',
              onPressed: () {},
            ),
            SizedBox(height: 2 * space),
            CustomButton(
              backgroundColor: kWhite,
              textColor: kBlack.withOpacity(0.5),
              text: 'Continue with Google',
              image: Image(
                image: AssetImage('images/google_logo.png'),
                height: 48.0,
              ),
              onPressed: () {},
            ),
            SizedBox(height: space),
            CustomButton(
              backgroundColor: kBlack,
              textColor: kWhite,
              text: 'Create a Bubble Account',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;

  const CustomTextField(
      {Key key, this.label, this.prefixIcon, this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(kPaddingS),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.12),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          hintText: label,
          hintStyle: TextStyle(
            color: kBlack.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: kBlack.withOpacity(0.5),
          )),
    );
  }
}
