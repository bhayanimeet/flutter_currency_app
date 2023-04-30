import 'dart:async';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/google_ads_helper.dart';
import '../../res/global.dart';
import 'homepage.dart';
import 'intro_1.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
          () => Get.off(
            () => (Global.isVisited == false)
            ? const IntroScreen1()
            : (Global.isLogged == false)
            ? const LoginScreen()
            : const HomePage(),
        curve: Curves.easeInOut,
        transition: Transition.fadeIn,
      ),
    );
    AdHelper.adHelper.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: -440, end: 0),
              builder: (context, val, widget) => Transform.translate(
                offset: Offset(0, val),
                child: Image.asset(
                  'assets/images/icon.png',
                  filterQuality: FilterQuality.high,
                  scale: 3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Currency converter",
                  curve: Curves.easeInOut,
                  cursor: '',
                  speed: const Duration(milliseconds: 200),
                  textStyle: GoogleFonts.arya(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
