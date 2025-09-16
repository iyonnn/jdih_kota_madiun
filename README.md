

samples, guidance on mobile development, and a full API reference.

# JDIH Kota Madiun — Dokumentasi Teknis

## 1. Ringkasan Perubahan Utama

- Refaktor struktur aplikasi menjadi modular: setiap menu utama dan sub menu dipisah ke file/page sendiri.
- Implementasi global BottomNavigationBar dengan ikon asset, urutan dan ikon disesuaikan permintaan.
- Penyesuaian struktur menu dan submenu agar identik dengan versi web, termasuk nested submenu pada Dokumen Lainnya.
- Seluruh tampilan submenu menggunakan Card, border oranye (#ffb13b), ripple oranye, dan ikon.
- AppBar seluruh halaman utama dan sub menu kini konsisten: hitam, judul putih tebal, centerTitle: true.
- Skema warna dan UX diselaraskan dengan website JDIH Kota Madiun.
- Dokumentasi dan konfigurasi lingkungan pengembangan diperjelas.

## 2. Masalah Teknis yang Ditemui

- Ketidakcocokan versi Gradle, AGP, dan Kotlin dengan Java 21 dan Flutter 3.13.9.
- Konflik dependency pada pubspec.yaml (plugin tidak kompatibel dengan Flutter versi terbaru).
- Error build terkait minSdkVersion, compileSdkVersion, dan targetSdkVersion di Android.
- Warning dan error saat menjalankan flutter pub get dan build (dependency conflict, pub outdated).
- Error sintaks, import, dan kurung kurawal setelah refaktor struktur kode.
- Inkonsistensi tampilan AppBar (judul tidak di tengah) pada beberapa halaman.
- Struktur menu dan submenu belum konsisten dengan versi web.

## 3. Langkah Perbaikan

- Update versi Gradle, AGP, dan Kotlin di file android/build.gradle, android/app/build.gradle, dan gradle wrapper agar kompatibel dengan Java 21 dan Flutter 3.13.9.
- Update dan sinkronisasi dependency di pubspec.yaml ke versi stable yang kompatibel dengan Flutter terbaru, serta resolve conflict dan warning.
- Sesuaikan minSdkVersion, compileSdkVersion, dan targetSdkVersion di android/app/build.gradle sesuai requirement Flutter dan plugin.
- Jalankan perintah flutter pub get, flutter clean, dan build ulang hingga aplikasi berjalan tanpa error.
- Koreksi error sintaks, import, dan kurung kurawal pada file yang terdampak refaktor.
- Penambahan properti centerTitle: true pada AppBar di seluruh halaman utama dan sub menu agar tampilan konsisten.
- Refaktor struktur menu dan submenu agar identik dengan versi web, serta implementasi ListView dan nested submenu sesuai kebutuhan.

## 4. Konfigurasi Lingkungan Pengembangan

- **Flutter SDK**: 3.35.3 (stable)
- **Dart SDK**: 3.9.2 (stable)
- **Android Gradle Plugin (AGP)**: 8.1.2
- **Gradle Wrapper**: 8.2.1
- **Kotlin**: 1.9.10
- **Java**: OpenJDK 21 (Java 21)
- **Android SDK**: 36.1.0-rc1 (compileSdkVersion 36, targetSdkVersion 36, minSdkVersion 21)
- **Xcode**: 15.x (untuk build iOS, jika diperlukan)
- **Dependency utama**: flutter_inappwebview: ^6.0.0, permission_handler: ^11.0.1 (lihat pubspec.yaml untuk daftar lengkap)

## 5. Build & Jalankan Aplikasi

1. Pastikan seluruh environment sesuai dengan konfigurasi di atas.
2. Jalankan `flutter pub get` untuk mengunduh dependency.
3. Gunakan `flutter run` untuk menjalankan aplikasi pada emulator atau perangkat fisik.
4. Untuk build release, gunakan `flutter build apk` (Android) atau `flutter build ios` (iOS).

Referensi tambahan:
- [Flutter Documentation](https://docs.flutter.dev/)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
