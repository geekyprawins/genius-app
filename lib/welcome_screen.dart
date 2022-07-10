import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:genius/providers/user_provider.dart';
import 'package:genius/registration_screen.dart';
import 'package:genius/widgets/animated_page_route.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller!
      ..forward()
      // animation.addStatusListener((status) {
      //   if (status == AnimationStatus.completed) {
      //     controller.reverse(from: 1.0);
      //   } else if (status == AnimationStatus.dismissed) {
      //     controller.forward();
      //   }
      // });
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: animation!.value as Color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome to Genius!',
                          speed: const Duration(milliseconds: 100),
                          cursor: '🎶',
                          curve: Curves.easeIn,
                        ),
                        TypewriterAnimatedText(
                          'Search your favourite songs..',
                          cursor: '🎶',
                          speed: const Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                        ),
                      ],
                    ),
                  ),
                ),
                // TypewriterAnimatedTextKit(
                //   text: ['Genius App'],
                //   speed: Duration(milliseconds: 200),
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Material(
                elevation: 5,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      AnimatedPageRoute(
                        LoginScreen(),
                      ),
                    );
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      AnimatedPageRoute(
                        RegistrationScreen(
                          up: userProvider,
                        ),
                      ),
                    );
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
