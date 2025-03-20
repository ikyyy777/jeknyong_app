import 'package:flutter/material.dart';

class DaftarAkunController extends ChangeNotifier {
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nomorWhatsappController = TextEditingController();
  final TextEditingController kodePosController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController alamatLengkapController = TextEditingController();

  String selectedGender = '';
  String selectedKecamatan = '';
  String selectedDesa = '';

  // dummy data
  final List<Map<String, dynamic>> kecamatanList = [
    {'label': 'Kecamatan Bogor Barat', 'value': 'bogor_barat'},
    {'label': 'Kecamatan Bogor Selatan', 'value': 'bogor_selatan'}, 
    {'label': 'Kecamatan Bogor Tengah', 'value': 'bogor_tengah'},
    {'label': 'Kecamatan Bogor Timur', 'value': 'bogor_timur'},
    {'label': 'Kecamatan Bogor Utara', 'value': 'bogor_utara'},
    {'label': 'Kecamatan Tanah Sareal', 'value': 'tanah_sareal'},
  ];

  // dummy data
  final List<Map<String, dynamic>> desaList = [
    {'label': 'Desa Bogor Barat', 'value': 'bogor_barat'},
    {'label': 'Desa Bogor Selatan', 'value': 'bogor_selatan'},
    {'label': 'Desa Bogor Tengah', 'value': 'bogor_tengah'},
  ];

  void setSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setSelectedKecamatan(String kecamatan) {
    selectedKecamatan = kecamatan;
    notifyListeners();
  }

  void setSelectedDesa(String desa) {
    selectedDesa = desa;
    notifyListeners();
  }
}
