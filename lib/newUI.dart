// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class newUI extends StatelessWidget {
  const newUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 23, 162, 184),
                Color.fromARGB(255, 23, 162, 184),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          "JDIH Kota Madiun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            buildMenuCard(context,
                title: 'BERANDA',
                iconPath: 'assets/img/berita.png',
                url: 'https://jdih.madiunkota.go.id/'),
            buildMenuCard(
              context,
              title: 'PROFIL',
              iconPath: 'assets/img/beranda.png',
              submenu: [
                {
                  'title': 'Sejarah JDIH',
                  'url': 'https://jdih.madiunkota.go.id/sejarah/jdih'
                },
                {
                  'title': 'Dasar Hukum',
                  'url': 'https://jdih.madiunkota.go.id/dasar/hukum'
                },
                {
                  'title': 'Struktur Organisasi',
                  'url': 'https://jdih.madiunkota.go.id/struktur/organisasi'
                },
                {
                  'title': 'SK TIM',
                  'url': 'https://jdih.madiunkota.go.id/sk/tim'
                },
                {'title': 'SOP', 'url': 'https://jdih.madiunkota.go.id/sop'},
              ],
            ),
            buildMenuCard(
              context,
              title: 'PRODUK HUKUM',
              iconPath: 'assets/img/produkhukum.png',
              submenu: [
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
              ],
            ),
            buildMenuCard(
              context,
              title: 'DOKUMEN LAINNYA',
              iconPath: 'assets/img/propemperda.png',
              submenu: [
                {
                  'title': 'Monografi Hukum',
                  'submenu': [
                    {
                      'title': 'Koleksi Buku',
                      'url': 'https://jdih.madiunkota.go.id/buku'
                    },
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
                {
                  'title': 'Instruksi Walikota',
                  'url': 'https://example.com/instruksi'
                },
                {
                  'title': 'Surat Edaran',
                  'url': 'https://example.com/surat-edaran'
                },
              ],
            ),
            buildMenuCard(
              context,
              title: 'INFORMASI STATISTIK',
              iconPath: 'assets/img/bankumaskin.png',
              submenu: [
                {
                  'title': 'Berita',
                  'url': 'https://jdih.madiunkota.go.id/berita'
                },
                {
                  'title': 'Perjanjian Kerja',
                  'url': 'https://jdih.madiunkota.go.id/perjanjian/kerja/sama'
                },
                {
                  'title': 'Bantuan Hukum',
                  'url': 'https://jdih.madiunkota.go.id/bankumaskin'
                },
              ],
            ),
            buildMenuCard(context,
                title: 'KONTAK',
                iconPath: 'assets/img/profil.png',
                url: 'https://jdih.madiunkota.go.id/kontak'),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard(
    BuildContext context, {
    required String title,
    required String iconPath,
    String? url,
    List<Map<String, dynamic>>? submenu,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (submenu != null) {
            showSubMenu(context, title, submenu);
          } else if (url != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewPage(title: title, url: url)),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void showSubMenu(
      BuildContext context, String title, List<Map<String, dynamic>> submenu) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: submenu.length,
          itemBuilder: (context, index) {
            final item = submenu[index];
            if (item.containsKey('submenu')) {
              return ListTile(
                title: Text(item['title']),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  showSubMenu(context, item['title'], item['submenu']);
                },
              );
            } else {
              return ListTile(
                title: Text(item['title']),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            title: item['title'], url: item['url']!)),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  double _progress = 0;
  bool canGoBack = false;

  @override
  void initState() {
    super.initState();
    _initFlutterDownloader();
  }

  Future<void> _initFlutterDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Meminta izin di sini
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();

    // Cek apakah izin diberikan atau tidak
    if (statuses[Permission.camera]?.isGranted == false) {
      print('Permission to access camera is denied');
    }
    if (statuses[Permission.storage]?.isGranted == false) {
      print('Permission to access storage is denied');
    }
    if (statuses[Permission.photos]?.isGranted == false) {
      print('Permission to access photos is denied');
    }
    if (statuses[Permission.mediaLibrary]?.isGranted == false) {
      print('Permission to access media library is denied');
    }
    if (statuses[Permission.accessMediaLocation]?.isGranted == false) {
      print('Permission to access media location is denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: canGoBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () async {
                  if (canGoBack) {
                    await _webViewController?.goBack();
                  }
                },
              )
            : null,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 25, 26, 27),
                Color.fromARGB(255, 25, 26, 27),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                clearCache: false,
                cacheEnabled: true,
                transparentBackground: true,
                supportZoom: true,
                useOnDownloadStart: true,
                mediaPlaybackRequiresUserGesture: false,
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                javaScriptCanOpenWindowsAutomatically: true,
                javaScriptEnabled: true,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
                allowContentAccess: true,
                allowFileAccess: true,
              ),
            ),
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              var response = await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Permintaan Izin"),
                  content:
                      const Text("Ijinkan aplikasi mengakses Penyimpanan?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(PermissionRequestResponseAction.GRANT);
                      },
                      child: const Text("Izinkan Akses"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(PermissionRequestResponseAction.DENY);
                      },
                      child: const Text("Tolak Akses"),
                    ),
                  ],
                ),
              );

              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) async {
              setState(() {
                _progress = 0;
              });
              canGoBack = await controller.canGoBack();
            },
            onLoadStop: (controller, url) async {
              setState(() {
                _progress = 1;
              });
              canGoBack = await controller.canGoBack();

              // Menghilangkan elemen header jika diperlukan
              controller.evaluateJavascript(source: '''
                var header = document.querySelector('header');
                if (header) header.style.display = 'none';
              ''');
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
            onDownloadStart: (controller, url) async {
              bool? userConsent = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: Colors.white,
                    title: Row(
                      children: const [
                        Icon(Icons.file_download, color: Colors.orange),
                        SizedBox(width: 10),
                        Text(
                          "Konfirmasi Unduhan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Apakah Anda ingin mengunduh dokumen ini?",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Icon(
                          Icons.file_present,
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false); // Pengguna menolak
                        },
                        child: Text(
                          "Tidak",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true); // Pengguna setuju
                        },
                        child: Text(
                          "Ya",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              );

              // Jika pengguna menyetujui, lanjutkan proses unduhan
              if (userConsent == true) {
                final String url_files = "$url";
                void launchURL_files() async => await canLaunch(url_files)
                    ? await launch(url_files)
                    : throw 'Could not launch $url_files';
                launchURL_files();
              } else {
                print("Unduhan dibatalkan oleh pengguna.");
              }
            },
          ),
          if (_progress < 1)
            LinearProgressIndicator(value: _progress, color: Colors.orange),
        ],
      ),
    );
  }
}
