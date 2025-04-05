import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampahTanpaDipilahForm {
  String? alamat;
  String? catatan;
  int? noHP;
  String? fotoSampahPath;
  
  bool get isFotoValid => fotoSampahPath != null && fotoSampahPath!.isNotEmpty;
  bool get isAlamatValid => alamat != null && alamat!.isNotEmpty;
  bool get isCatatanValid => catatan != null && catatan!.isNotEmpty;
  bool get isNoHPValid => noHP != null && noHP.toString().length >= 10 && noHP.toString().length <= 13;
  
  // validasi apakah form sudah lengkap
  bool get isFormLengkap => isFotoValid && isNoHPValid;
}

class JualSampahTanpaDipilahController extends ChangeNotifier {
  final SampahTanpaDipilahForm form = SampahTanpaDipilahForm();
  bool _isSubmitting = false;
  String? _errorMessage;
  
  // Tambahkan TextEditingController
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  
  JualSampahTanpaDipilahController() {
    // Tambahkan listener untuk update textfield
    noHpController.addListener(_onNoHpChanged);
    catatanController.addListener(_onCatatanChanged);
  }
  
  void _onNoHpChanged() {
    final text = noHpController.text;
    setNoHP(text);
  }
  
  void _onCatatanChanged() {
    setCatatan(catatanController.text);
  }
  
  @override
  void dispose() {
    noHpController.dispose();
    catatanController.dispose();
    super.dispose();
  }
  
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  bool get isBottomNavVisible => form.isFormLengkap;
  
  void setAlamat(String alamat) {
    form.alamat = alamat;
    notifyListeners();
  }

  void setNoHP(String noHP) {
    if (noHP.isEmpty) {
      form.noHP = null;
    } else {
      try {
        final parsed = int.parse(noHP);
        // Validasi panjang nomor HP
        if (noHP.length >= 10 && noHP.length <= 13) {
          form.noHP = parsed;
        } else {
          form.noHP = null;
        }
      } catch (e) {
        form.noHP = null;
      }
    }
    notifyListeners();
  }
  
  void setCatatan(String catatan) {
    form.catatan = catatan;
    notifyListeners();
  }
  
  void setFoto(String path) {
    form.fotoSampahPath = path;
    notifyListeners();
  }
  
  void removeFoto() {
    form.fotoSampahPath = null;
    notifyListeners();
  }
  
  void resetForm() {
    form.alamat = null;
    form.catatan = null;
    form.noHP = null;
    form.fotoSampahPath = null;
    _errorMessage = null;
    
    // Reset text controller
    noHpController.clear();
    catatanController.clear();
    
    notifyListeners();
  }
  
  Future<bool> submitForm() async {
    if (!form.isFormLengkap) {
      _errorMessage = "Mohon lengkapi semua data yang diperlukan";
      notifyListeners();
      return false;
    }
    
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      // Simulasi proses pengiriman data ke server
      await Future.delayed(const Duration(seconds: 2));
      _isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSubmitting = false;
      _errorMessage = "Terjadi kesalahan: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // Ambil data alamat dari shared preferences 
  Future<Map<String, dynamic>> getAddressFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // Baca data terbaru dari SharedPreferences
      String? address = prefs.getString('selectedAddress');
      double? latitude = prefs.getDouble('selectedLatitude');
      double? longitude = prefs.getDouble('selectedLongitude');
      String? subLocality = prefs.getString('selectedSubLocality');
  
      // Log data yang dibaca untuk debugging
      log("JualSampahController - Membaca alamat: $address");
      if (subLocality != null) {
        log("JualSampahController - Membaca subLocality: $subLocality");
      } else {
        log("JualSampahController - subLocality tidak ditemukan");
      }
      
      // Jika ada alamat yang disimpan, update form
      if (address != null && address.isNotEmpty) {
        setAlamat(address);
      }
  
      return {
        'address': address ?? '',
        'latitude': latitude ?? -7.7956,
        'longitude': longitude ?? 110.3695,
        'subLocality': subLocality ?? '',
      };
    } catch (e) {
      log("JualSampahController - Error membaca alamat: $e");
      return {
        'address': '',
        'latitude': -7.7956,
        'longitude': 110.3695,
        'subLocality': '',
      };
    }
  }
  
  // Sinkronkan data dengan SharedPreferences
  Future<void> syncAddressWithSharedPreferences() async {
    try {
      Map<String, dynamic> addressData = await getAddressFromSharedPreferences();
      if (addressData['address'] != null && addressData['address'].toString().isNotEmpty) {
        setAlamat(addressData['address']);
      }
    } catch (e) {
      log("Error sinkronisasi alamat: $e");
    }
  }
}