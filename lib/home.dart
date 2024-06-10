// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HalamanUtama extends StatelessWidget {
  final List<Map<String, String>> cardData = [
    {
      'name': 'BERANDA',
      'url': 'https://jdih.madiunkota.go.id/',
      'image': 'assets/img/beranda.png'
    },
    {
      'name': 'BERITA',
      'url': 'https://jdih.madiunkota.go.id/berita',
      'image': 'assets/img/berita.png'
    },
    {
      'name': 'NASKAH AKADEMIK',
      'url': 'https://jdih.madiunkota.go.id/naskah/akademik',
      'image': 'assets/img/beranda.png'
    },
    {
      'name': 'BUKU',
      'url': 'https://jdih.madiunkota.go.id/buku',
      'image': 'assets/img/beranda.png'
    },
    {
      'name': 'STATISTIK',
      'url': 'https://jdih.madiunkota.go.id/statistik',
      'image': 'assets/img/beranda.png'
    },
    {
      'name': 'SEJARAH',
      'url': 'https://jdih.madiunkota.go.id/sejarah/jdih',
      'image': 'assets/img/profil.png'
    },
    {
      'name': 'STRUKTUR ORGANISASI',
      'url': 'https://jdih.madiunkota.go.id/struktur/organisasi',
      'image': 'assets/img/berita.png'
    },
    {
      'name': 'DASAR HUKUM',
      'url': 'https://jdih.madiunkota.go.id/dasar/hukum',
      'image': 'assets/img/produkhukum.png'
    },
    {
      'name': 'SK TIM',
      'url': 'https://jdih.madiunkota.go.id/sk/tim',
      'image': 'assets/img/propemperda.png'
    },
    {
      'name': 'S.O.P',
      'url': 'https://jdih.madiunkota.go.id/sop',
      'image': 'assets/img/bankumaskin.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
                offset: Offset(0, 3),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: screenHeight * 0.01),
              ListCard(),
              SizedBox(height: screenHeight * 0.001),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  padding: EdgeInsets.only(top: screenHeight * 0.002),
                  children: List.generate(cardData.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        _handleCardTap(context, cardData[index]['url']!);
                      },
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.020,
                            horizontal: screenWidth * 0.030),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(cardData[index]['image']!),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.020,
                                        screenWidth * 0.008,
                                        screenWidth * 0.020,
                                        screenWidth * 0.008),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 23, 162, 184)
                                          .withOpacity(1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Text(
                                      cardData[index]['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              // Tambahkan widget ListCard disini
              // Move ListCard here
            ],
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;
  bool isDesktopMode = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.home, color: Colors.black),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () async {
                    if (_webViewController != null) {
                      await _webViewController?.reload();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.refresh, color: Colors.black),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () async {
                    if (_webViewController != null) {
                      await _webViewController?.goBack();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isDesktopMode = !isDesktopMode;
                    });
                    if (_webViewController != null) {
                      await _webViewController?.setOptions(
                        options: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                            userAgent: isDesktopMode
                                ? "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
                                : "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36",
                          ),
                        ),
                      );
                      await _webViewController?.reload();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDesktopMode
                          ? Icons.mobile_friendly
                          : Icons.desktop_windows,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptEnabled: true,
                        clearCache: true,
                        cacheEnabled: true,
                        transparentBackground: true,
                        verticalScrollBarEnabled: true,
                        horizontalScrollBarEnabled: true,
                        disableVerticalScroll: false,
                        disableHorizontalScroll: false,
                      ),
                    ),
                    onWebViewCreated: (controller) async {
                      _webViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 23, 162, 184),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pilih Salah Satu Produk Hukum :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3, // Jumlah kolom dalam grid
            crossAxisSpacing: 16.0, // Jarak horizontal antara elemen grid
            mainAxisSpacing: 1.0, // Jarak vertikal antara elemen grid
            childAspectRatio: 1, // Atur rasio lebar terhadap tinggi
            children: [
              PeraturanCard(
                title: 'Peraturan Walikota',
                jenis: 'Peraturan Daerah',
              ),
              PeraturanCard(
                title: 'Instruksi Walikota',
                jenis: 'Instruksi Wali Kota',
              ),
              PeraturanCard(
                title: 'Keputusan Walikota',
                jenis: 'Keputusan Wali Kota',
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '<<<<<',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: screenHeight * 0.03),
              Text(
                'Informasi Lainya',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: screenHeight * 0.03),
              Text(
                '>>>>>',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PeraturanCard extends StatelessWidget {
  final String title;
  final String jenis;

  const PeraturanCard({required this.title, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Gunakan Center agar Card berada di tengah
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfListPage(title: title, jenis: jenis),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize:
                MainAxisSize.min, // Menyesuaikan ukuran Card dengan kontennya
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(0.0),
              //   child: Image.asset(
              //     'assets/img/legal.png', // Ganti dengan path gambar Anda
              //     fit: BoxFit.cover,
              //     width: 50, // Tetapkan lebar tetap atau sesuai kebutuhan
              //     height: 50, // Tetapkan tinggi tetap atau sesuai kebutuhan
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfListPage extends StatefulWidget {
  final String title;
  final String jenis;

  const PdfListPage({required this.title, required this.jenis});

  @override
  _PdfListPageState createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  List<dynamic>? allFiles;
  List<dynamic>? filteredFiles;

  @override
  void initState() {
    super.initState();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    final response = await http
        .get(Uri.parse('https://jdih.madiunkota.go.id/api/integrasi'));
    if (response.statusCode == 200) {
      setState(() {
        allFiles = jsonDecode(response.body);
        filteredFiles = List.from(allFiles!);
      });
    } else {
      throw Exception('Failed to load PDF files');
    }
  }

  void filterFiles(String query) {
    if (allFiles != null) {
      setState(() {
        filteredFiles = allFiles!
            .where((file) =>
                file['judul'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar File ${widget.title}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan judul...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterFiles,
            ),
          ),
          Expanded(
            child: filteredFiles != null
                ? ListView.builder(
                    itemCount: filteredFiles!.length,
                    itemBuilder: (context, index) {
                      var file = filteredFiles![index];
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        elevation: 4.0,
                        child: SizedBox(
                          // Menggunakan SizedBox untuk membatasi ukuran widget
                          height: screenHeight * 0.2,
                          child: ListTile(
                            title: Text(
                              file['judul'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                            subtitle: Text(
                                'Tanggal Pengundangan: ${file['tanggal_pengundangan']}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViewPage(
                                    url: file['urlDownload'],
                                  ),
                                ),
                              );
                            },
                            trailing: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewPage(
                                      url: file['urlDownload'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text('Lihat',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  final String url;

  const PdfViewPage({required this.url});

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String? localPath;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    final url = widget.url;
    final filename = url.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (await file.exists()) {
      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } else {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
        // Tampilkan dialog jika file PDF tidak ditemukan
        _showErrorDialog(context);
      }
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('File PDF tidak ditemukan.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lihat PDF'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      if (isError || localPath == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('File PDF tidak ditemukan atau terjadi kesalahan.'),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lihat PDF'),
          ),
          body: PDFView(filePath: localPath!),
        );
      }
    }
  }
}
