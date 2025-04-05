import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/jenis_sampah_model.dart';

class JualSampahDipilahController extends ChangeNotifier {
  // Properti untuk Kategori dan Jenis Sampah
  List<JenisSampah> get daftarJenisSampah => _daftarJenisSampah;
  List<String> get kategoriList => ['Semua', ..._daftarJenisSampah.map((e) => e.kategori).toSet()];
  
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

  // Properti untuk Alamat
  String _address = '';
  String _subLocality = '';
  
  String get address => _address;
  String get subLocality => _subLocality;

  // Properti untuk Informasi Tambahan
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  
  String _noHp = '';
  String _catatan = '';
  
  String get noHp => _noHp;
  String get catatan => _catatan;

  // Konstruktor
  JualSampahDipilahController() {
    _loadSavedData();
    syncAddressWithSharedPreferences();
  }

  // Metode-metode untuk Alamat
  Future<Map<String, dynamic>> getAddressFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // Baca data terbaru dari SharedPreferences
      String? address = prefs.getString('selectedAddress');
      double? latitude = prefs.getDouble('selectedLatitude');
      double? longitude = prefs.getDouble('selectedLongitude');
      String? subLocality = prefs.getString('selectedSubLocality');
  
      // Log data yang dibaca untuk debugging
      log("JualSampahDipilahController - Membaca alamat: $address");
      if (subLocality != null) {
        log("JualSampahDipilahController - Membaca subLocality: $subLocality");
      } else {
        log("JualSampahDipilahController - subLocality tidak ditemukan");
      }
      
      // Jika ada alamat yang disimpan, update
      if (address != null && address.isNotEmpty) {
        _address = address;
      }
      
      if (subLocality != null) {
        _subLocality = subLocality;
      }
      
      notifyListeners();
  
      return {
        'address': address ?? '',
        'latitude': latitude ?? -7.7956,
        'longitude': longitude ?? 110.3695,
        'subLocality': subLocality ?? '',
      };
    } catch (e) {
      log("JualSampahDipilahController - Error membaca alamat: $e");
      return {
        'address': '',
        'latitude': -7.7956,
        'longitude': 110.3695,
        'subLocality': '',
      };
    }
  }
  
  // Sinkronkan data alamat dengan SharedPreferences
  Future<void> syncAddressWithSharedPreferences() async {
    try {
      Map<String, dynamic> addressData = await getAddressFromSharedPreferences();
      if (addressData['address'] != null && addressData['address'].toString().isNotEmpty) {
        _address = addressData['address'];
        _subLocality = addressData['subLocality'];
        notifyListeners();
      }
    } catch (e) {
      log("Error sinkronisasi alamat: $e");
    }
  }
  
  Future<void> saveAddress(String address, String subLocality) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Simpan data dengan key yang sama seperti di pilih_lokasi_controller
    await prefs.setString('selectedAddress', address);
    await prefs.setString('selectedSubLocality', subLocality);
    
    _address = address;
    _subLocality = subLocality;
    notifyListeners();
  }

  // Metode-metode untuk Informasi Tambahan  
  void setNoHP(String value) {
    _noHp = value;
    notifyListeners();
  }
  
  void setCatatan(String value) {
    _catatan = value;
    notifyListeners();
  }
  
  Future<void> saveInformasiTambahan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('noHp', _noHp);
    await prefs.setString('catatan', _catatan);
  }
  
  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Load data no hp dan catatan
    _noHp = prefs.getString('noHp') ?? '';
    _catatan = prefs.getString('catatan') ?? '';
    
    noHpController.text = _noHp;
    catatanController.text = _catatan;
    
    notifyListeners();
  }

  @override
  void dispose() {
    noHpController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  // Daftar Jenis Sampah
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