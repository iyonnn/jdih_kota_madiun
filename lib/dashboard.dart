import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar File Peraturan Kota Madiun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
      ),
    );
  }
}

class PeraturanCard extends StatelessWidget {
  final String title;
  final String jenis;

  PeraturanCard({required this.title, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfListPage(title: title, jenis: jenis),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class PdfListPage extends StatelessWidget {
  final String title;
  final String jenis;

  PdfListPage({required this.title, required this.jenis});

  Future<List<dynamic>> fetchPdfFiles() async {
    final response = await http
        .get(Uri.parse('https://jdih.madiunkota.go.id/api/integrasi'));

    if (response.statusCode == 200) {
      List<dynamic> allFiles = jsonDecode(response.body);
      List<dynamic> filteredFiles =
          allFiles.where((file) => file['jenis'] == jenis).toList();
      return filteredFiles;
    } else {
      throw Exception('Failed to load PDF files');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPdfFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No PDF files available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var file = snapshot.data![index];
                return ListTile(
                  title: Text(file['judul']),
                  subtitle: Text(
                      'Tanggal Pengundangan: ${file['tanggal_pengundangan']}'),
                  onTap: () {
                    // Implementasi membuka file PDF di halaman baru
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewPage(url: file['urlDownload']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  final String url;

  PdfViewPage({required this.url});

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String? localPath;

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
      });
    } else {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localPath = file.path;
        });
      } else {
        throw Exception('Failed to download PDF file');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat PDF'),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath!,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
