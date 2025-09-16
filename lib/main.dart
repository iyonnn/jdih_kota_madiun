import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'screens/main_menu.dart';
// import 'screens/beranda_page.dart';
// import 'screens/profil_page.dart';
// import 'screens/produk_hukum_page.dart';
// import 'screens/dokumen_lainnya_page.dart';
// import 'screens/informasi_statistik_page.dart';
// import 'screens/kontak_page.dart';
// import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi FlutterDownloader
  await FlutterDownloader.initialize(
    debug: true, // debug: false untuk versi produksi
  );

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();
      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JDIH Kota Madiun',
      home: AnimatedSplashScreen(
        splash: 'assets/img/splash.gif',
        nextScreen: const MainMenu(),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: PageTransitionType.fade,
        splashIconSize: double.infinity,
        backgroundColor: const Color(0xffe5e5e5),
      ),
    );
  }
}
