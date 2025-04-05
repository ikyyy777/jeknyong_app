import 'dart:developer';
import 'package:flutter/material.dart';

import '../models/jenis_sampah_model.dart';
import 'jual_sampah_dipilah_controller.dart';

// Model untuk jenis sampah

// Model untuk item keranjang
class KeranjangItem {
  final JenisSampah jenisSampah;
  double berat;
  double get totalHarga => jenisSampah.hargaPerKg * berat;

  KeranjangItem({
    required this.jenisSampah,
    required this.berat,
  });
}

class KeranjangJualSampahDipilahController extends ChangeNotifier {
  // List keranjang items
  final List<KeranjangItem> _items = [];
  
  // Reference ke controller jual sampah dipilah
  final JualSampahDipilahController _jualSampahController;
  
  // Constructor dengan dependency injection
  KeranjangJualSampahDipilahController(this._jualSampahController);
  
  // Getter untuk items
  List<KeranjangItem> get items => _items;
  
  // Getter untuk jenis sampah
  List<JenisSampah> get jenisSampah => _jualSampahController.daftarJenisSampah;
  
  // Total harga keranjang
  double get totalHarga {
    return _items.fold(0, (sum, item) => sum + item.totalHarga);
  }
  
  // Total berat keranjang
  double get totalBerat {
    return _items.fold(0, (sum, item) => sum + item.berat);
  }
  
  // Jumlah item dalam keranjang
  int get itemCount => _items.length;
  
  // Cek apakah keranjang kosong
  bool get isEmpty => _items.isEmpty;
  
  // Tambah item ke keranjang
  void tambahItem(JenisSampah jenisSampah, double berat) {
    // Cari apakah jenis sampah sudah ada di keranjang
    int existingIndex = _items.indexWhere((item) => item.jenisSampah.id == jenisSampah.id);
    
    if (existingIndex >= 0) {
      // Update berat jika sudah ada
      _items[existingIndex].berat += berat;
      log('Item ${jenisSampah.nama} ditambahkan, berat diupdate menjadi ${_items[existingIndex].berat}kg');
    } else {
      // Tambah item baru jika belum ada
      _items.add(KeranjangItem(
        jenisSampah: jenisSampah,
        berat: berat,
      ));
      log('Item baru ${jenisSampah.nama} ditambahkan dengan berat ${berat}kg');
    }
    
    notifyListeners();
  }
  
  // Update berat item di keranjang
  void updateBerat(String jenisSampahId, double beratBaru) {
    int index = _items.indexWhere((item) => item.jenisSampah.id == jenisSampahId);
    
    if (index >= 0) {
      // Pastikan berat baru tidak kurang dari minimum
      if (beratBaru < _items[index].jenisSampah.minimumBerat) {
        beratBaru = _items[index].jenisSampah.minimumBerat;
      }
      
      _items[index].berat = beratBaru;
      log('Berat item ${_items[index].jenisSampah.nama} diupdate menjadi ${beratBaru}kg');
      notifyListeners();
    }
  }
  
  // Hapus item dari keranjang
  void hapusItem(String jenisSampahId) {
    _items.removeWhere((item) => item.jenisSampah.id == jenisSampahId);
    log('Item dengan ID $jenisSampahId dihapus dari keranjang');
    notifyListeners();
  }
  
  // Kosongkan keranjang
  void kosongkanKeranjang() {
    _items.clear();
    log('Keranjang dikosongkan');
    notifyListeners();
  }
  
  // Dapatkan item berdasarkan ID
  KeranjangItem? getItemById(String jenisSampahId) {
    try {
      return _items.firstWhere((item) => item.jenisSampah.id == jenisSampahId);
    } catch (e) {
      return null;
    }
  }
  
  // Dapatkan JenisSampah berdasarkan ID
  JenisSampah? getJenisSampahById(String id) {
    try {
      return _jualSampahController.daftarJenisSampah.firstWhere((sampah) => sampah.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Tambahkan beberapa item dummy ke keranjang untuk testing
  void addDummyItems() {
    if (_items.isEmpty && _jualSampahController.daftarJenisSampah.isNotEmpty) {
      // Tambah 2 jenis sampah pertama sebagai dummy
      final sampah1 = _jualSampahController.daftarJenisSampah[0];
      final sampah2 = _jualSampahController.daftarJenisSampah.length > 1 
          ? _jualSampahController.daftarJenisSampah[1] 
          : _jualSampahController.daftarJenisSampah[0];
          
      tambahItem(sampah1, sampah1.minimumBerat + 1.5);
      tambahItem(sampah2, sampah2.minimumBerat * 2);
      
      log('Item dummy ditambahkan ke keranjang');
    }
  }
}