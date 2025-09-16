import 'package:flutter/material.dart';
import 'beranda_page.dart';
import 'profil_page.dart';
import 'produk_hukum_page.dart';
import 'dokumen_lainnya_page.dart';
import 'informasi_statistik_page.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    BerandaPage(),
    ProdukHukumPage(),
    DokumenLainnyaPage(),
    InformasiStatistikPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/beranda.png', width: 28, height: 28),
            label: 'BERANDA',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/produkhukum.png',
                width: 28, height: 28),
            label: 'PRODUK',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/propemperda.png',
                width: 28, height: 28),
            label: 'DOKUMEN',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/bankumaskin.png', width: 28, height: 28),
            label: 'STATISTIK',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/profil.png', width: 28, height: 28),
            label: 'PROFIL',
          ),
        ],
      ),
    );
  }
}
