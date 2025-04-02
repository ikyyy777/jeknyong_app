import 'package:flutter/material.dart';

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
  
  @override
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

  // Tambahkan getter untuk memudahkan debugging
  bool get isNoHPValid => form.isNoHPValid;
  bool get isFotoValid => form.isFotoValid;
  bool get isFormLengkap => form.isFormLengkap;
}