import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InformasiStatistikPage extends StatelessWidget {
  const InformasiStatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        elevation: 2,
      ),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri('https://jdih.madiunkota.go.id/statistik')),
      ),
    );
  }
}
