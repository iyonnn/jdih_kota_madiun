import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DokumenLainnyaPage extends StatelessWidget {
  DokumenLainnyaPage({super.key});

  final List<Map<String, dynamic>> submenu = [
    {
      'title': 'Monografi Hukum',
      'submenu': [
        {'title': 'Koleksi Buku', 'url': 'https://jdih.madiunkota.go.id/buku'},
        {
          'title': 'Naskah Akademik',
          'url': 'https://jdih.madiunkota.go.id/naskah/akademik'
        },
        {
          'title': 'Karya Tulis',
          'url': 'https://jdih.madiunkota.go.id/karya/tulis'
        },
      ]
    },
    {
      'title': 'Artikel Hukum',
      'url': 'https://jdih.madiunkota.go.id/artikel/hukum'
    },
    {
      'title': 'Putusan/Yurisprudensi',
      'submenu': [
        {
          'title': 'Pengadilan Negeri',
          'url': 'https://sipp.pn-madiunkota.go.id/'
        },
        {
          'title': 'Pengadilan Agama',
          'url':
              'https://putusan3.mahkamahagung.go.id/pengadilan/profil/pengadilan/pa-madiun.html'
        },
      ]
    },
    {
      'title': 'Dokumen Langka',
      'url': 'https://jdih.madiunkota.go.id/dokumen/langka/index'
    },
    {'title': 'Instruksi Wali Kota', 'url': 'https://jdih.madiunkota.go.id/kategori/eyJpdiI6Ii9tQ29CL2NSNGhPeW8wSnhUTVhlekE9PSIsInZhbHVlIjoiYWV0bGk0VG1KZlZCZDBqcDNOdnptdz09IiwibWFjIjoiMzljZmI5NWZhMzgzNDVkNTQ5MjNmY2E5NmU5MThkN2M5MjRiYmQ1ZmIzMDc5MWQ0OGUzZTU0MjNiMmE1ZDQwOSJ9'},
    {
      'title': 'Surat Edaran',
      'submenu': [
        {
          'title': 'Wali Kota',
          'url': 'https://jdih.madiunkota.go.id/kategori/eyJpdiI6IlBZazVtMm9rMkRXNkorei9aTW9QbFE9PSIsInZhbHVlIjoidFFtQ3F1VVVjcUY5ZmpIMzJ3U2t3Zz09IiwibWFjIjoiYTdhYThmMjk1NTQ4YWMwZGI2M2RiM2RjODA4ZWZjZjFmZDczNzc1ZjFiMDA3YzVjZTg2MzZkYTk3YmE1N2MzMCJ9'
        },
        {
          'title': 'Sekretaris Daerah',
          'url': 'https://jdih.madiunkota.go.id/kategori/eyJpdiI6IkJwbW9MNXdlUTIzbGU0R1NZRXNDZ3c9PSIsInZhbHVlIjoiSVRpUFFSckZCeXJKZlhFUEdGVmdZZz09IiwibWFjIjoiMDA2NjFmMDNjYjgyMjNjN2M5M2Q2MjZjMDVkNzMxMmIwYTkwMWI5YzBhOGI1MzRjMGM3MjRmMTBhODBkY2ZhYiJ9'
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen Lainnya'),
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
                  if (item['submenu'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SubmenuPage(
                          title: item['title'],
                          submenu:
                              List<Map<String, dynamic>>.from(item['submenu']),
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SimpleWebView(
                          title: item['title'],
                          url: item['url'],
                        ),
                      ),
                    );
                  }
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
                          item['title'],
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

class _SubmenuPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> submenu;
  const _SubmenuPage({required this.title, required this.submenu});

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
                  if (item['submenu'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SubmenuPage(
                          title: item['title'],
                          submenu:
                              List<Map<String, dynamic>>.from(item['submenu']),
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SimpleWebView(
                          title: item['title'],
                          url: item['url'],
                        ),
                      ),
                    );
                  }
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
                          item['title'],
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
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
      ),
    );
  }
}
