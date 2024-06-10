import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jdih_kota_madiun/dashboard.dart';
import 'package:jdih_kota_madiun/home.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JDIH Kota Madiun',
      home: AnimatedSplashScreen(
        splash: 'assets/img/splash.gif',
        nextScreen: HalamanUtama(),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: double.infinity,
        backgroundColor: const Color(0xffe5e5e5),
      ),
    );
  }
}
