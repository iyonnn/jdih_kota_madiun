import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProdukHukumPage extends StatelessWidget {
  const ProdukHukumPage({super.key});

  static final List<Map<String, String>> submenu = [
    {
      'title': 'Peraturan Daerah',
      'url': 'https://jdih.madiunkota.go.id/kategori/mobile/1'
    },
    {
      'title': 'Peraturan Wali Kota',
      'url': 'https://jdih.madiunkota.go.id/kategori/mobile/2'
    },
    {
      'title': 'Keputusan Wali Kota',
      'url': 'https://jdih.madiunkota.go.id/kategori/mobile/3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Hukum'),
        backgroundColor: Colors.black,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF6F8FA),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          itemCount: submenu.length,
          separatorBuilder: (context, idx) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = submenu[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFFFB13B), width: 1.2),
              ),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                splashColor: const Color(0x33FFB13B),
                highlightColor: const Color(0x22FFB13B),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _SimpleWebView(
                        title: item['title']!,
                        url: item['url']!,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_open,
                        color: Color(0xFFFFB13B),
                        size: 28,
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF232323),
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 18, color: Color(0xFFFFB13B)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SimpleWebView extends StatelessWidget {
  final String title;
  final String url;
  const _SimpleWebView({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
      ),
    );
  }
}
