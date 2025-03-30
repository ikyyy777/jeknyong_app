import 'package:flutter/material.dart';

class JenisSampah {
  final String id;
  final String nama;
  final String kategori;
  final double hargaPerKg;
  final double minimumBerat;
  final String gambar;
  final String deskripsi;

  JenisSampah({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.hargaPerKg,
    required this.minimumBerat,
    required this.gambar,
    required this.deskripsi,
  });
}

class JualSampahController extends ChangeNotifier {
  List<JenisSampah> get daftarJenisSampah => _daftarJenisSampah;
  List<String> get kategoriList => ['Semua', ..._daftarJenisSampah.map((e) => e.kategori).toSet().toList()];
  
  String _selectedKategori = 'Semua';
  String get selectedKategori => _selectedKategori;
  
  void setSelectedKategori(String kategori) {
    _selectedKategori = kategori;
    notifyListeners();
  }
  
  List<JenisSampah> get filteredSampah {
    if (_selectedKategori == 'Semua') {
      return _daftarJenisSampah;
    }
    return _daftarJenisSampah.where((sampah) => sampah.kategori == _selectedKategori).toList();
  }

  final List<JenisSampah> _daftarJenisSampah = [
    JenisSampah(
      id: '1',
      nama: 'Kuningan',
      kategori: 'Logam',
      hargaPerKg: 10000,
      minimumBerat: 0.5,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Jenis logam campuran tembaga dan seng',
    ),
    JenisSampah(
      id: '2',
      nama: 'Aluminium',
      kategori: 'Logam',
      hargaPerKg: 15000,
      minimumBerat: 0.5,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Logam ringan seperti kaleng minuman',
    ),
    JenisSampah(
      id: '3',
      nama: 'Besi',
      kategori: 'Logam',
      hargaPerKg: 8000,
      minimumBerat: 1.0,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Logam berat seperti potongan besi tua',
    ),
    JenisSampah(
      id: '4',
      nama: 'Kardus',
      kategori: 'Kertas',
      hargaPerKg: 3000,
      minimumBerat: 1.0,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Kardus bekas packaging',
    ),
    JenisSampah(
      id: '5',
      nama: 'Kertas HVS',
      kategori: 'Kertas',
      hargaPerKg: 5000,
      minimumBerat: 1.0,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Kertas buku, fotocopy, dan dokumen',
    ),
    JenisSampah(
      id: '6',
      nama: 'Kertas Koran',
      kategori: 'Kertas',
      hargaPerKg: 2500,
      minimumBerat: 1.0,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Koran bekas dan majalah',
    ),
    JenisSampah(
      id: '7',
      nama: 'Botol Plastik',
      kategori: 'Plastik',
      hargaPerKg: 4000,
      minimumBerat: 0.5,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Botol air mineral dan kemasan plastik',
    ),
    JenisSampah(
      id: '8',
      nama: 'Gelas Plastik',
      kategori: 'Plastik',
      hargaPerKg: 3500,
      minimumBerat: 0.5,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Gelas air mineral dan minuman kemasan',
    ),
    JenisSampah(
      id: '9',
      nama: 'Botol Kaca',
      kategori: 'Kaca',
      hargaPerKg: 1000,
      minimumBerat: 1.0,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Botol kaca minuman dan parfum',
    ),
    JenisSampah(
      id: '10',
      nama: 'Elektronik',
      kategori: 'Elektronik',
      hargaPerKg: 20000,
      minimumBerat: 0.5,
      gambar: 'assets/images/dummy_image.jpg',
      deskripsi: 'Barang elektronik rusak',
    ),
  ];
}