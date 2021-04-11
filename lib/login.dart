import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class SocialButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onClick;

  const SocialButton({Key key, this.icon, this.title, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Text(title),
        onTap: onClick,
      ),
    );
  }
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: CustomPaint(
          painter: BottomCurve(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Вход",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 30),
                  ),
                ),
                SocialButton(
                  icon: Icon(
                    FontAwesome5.google,
                    color: Colors.lightBlue,
                  ),
                  title: "Войти при помощи Google",
                  onClick: () => signInWithGoogle().then((acc) {
                    if (acc != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppHome(),
                        ),
                      );
                    }
                  }),
                ),
                // SocialButton(
                //   icon: Icon(
                //     FontAwesome5.facebook,
                //     color: Color.fromRGBO(0x42, 0x67, 0xb2, 1),
                //   ),
                //   title: "Войти при помощи Facebook",
                //   onClick: () {},
                // ),
                SocialButton(
                  icon: Icon(
                    FontAwesome5.phone,
                    color: Color.fromRGBO(0x25, 0xd3, 0x66, 1),
                  ),
                  title: "Войти при помощи номера телефона",
                  onClick: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    // var paint = Paint();
    // paint.color = Colors.green;
    // paint.style = PaintingStyle.fill;
    // paint.strokeWidth = 2.0;

    var backCurve = Path();
    backCurve.moveTo(0, size.height * 0.93);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
