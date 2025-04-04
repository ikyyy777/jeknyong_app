import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihLokasiController with ChangeNotifier {
  // Controller untuk Google Map
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  set mapController(GoogleMapController? controller) {
    if (_mapController != null) {
      // Lepaskan controller lama jika ada sebelum menetapkan yang baru
      // untuk mencegah memory leak
      _mapController!.dispose();
    }
    _mapController = controller;
    notifyListeners();
  }

  // Posisi awal default (Yogyakarta)
  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-7.7956, 110.3695),
    zoom: 15.0,
  );

  // State variables
  LatLng? _currentPosition;
  LatLng _selectedPosition = const LatLng(-7.7956, 110.3695);
  String _address = "Mencari alamat...";
  bool _isLoading = true;
  bool _isAddressLoading = false;
  bool _isCameraMoving = false;

  // Getters
  LatLng? get currentPosition => _currentPosition;
  LatLng get selectedPosition => _selectedPosition;
  String get address => _address;
  bool get isLoading => _isLoading;
  bool get isAddressLoading => _isAddressLoading;
  bool get isCameraMoving => _isCameraMoving;

  // Shared preferences variable
  String _subLocality = ''; // kecamatan

  // Variable static untuk melacak status inisialisasi renderer
  bool isRendererInitialized = false;

  // Inisialisasi renderer untuk Google Maps
  Future<void> initGoogleMapsRenderer() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        // Gunakan variable static untuk melacak apakah renderer sudah diinisialisasi
        if (!isRendererInitialized) {
          try {
            final GoogleMapsFlutterPlatform mapsImplementation =
                GoogleMapsFlutterPlatform.instance;
            if (mapsImplementation is GoogleMapsFlutterAndroid) {
              await mapsImplementation.initializeWithRenderer(
                AndroidMapRenderer.latest,
              );
              isRendererInitialized = true;
            }
          } catch (e) {
            // Jika terjadi kesalahan 'Renderer already initialized', tandai sebagai sudah diinisialisasi
            log("Info: Renderer mungkin sudah diinisialisasi: $e");
            isRendererInitialized = true;
          }
        }
      }
    } catch (e) {
      log("Error saat inisialisasi renderer maps: $e");
    }
  }

  // Mendapatkan lokasi saat ini
  Future<void> getCurrentLocation(BuildContext context) async {
    // Periksa apakah sudah loading, jika iya maka tidak perlu diproses lagi
    if (!_isLoading) return;

    // Notifikasi loading
    notifyListeners();

    try {
      // Periksa izin lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Izin lokasi ditolak')));
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Izin lokasi ditolak permanen. Silakan aktifkan di pengaturan',
            ),
          ),
        );
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Dapatkan posisi saat ini
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = LatLng(position.latitude, position.longitude);
      _selectedPosition = _currentPosition!;
      _isLoading = false;
      notifyListeners();

      // Pindah kamera ke posisi saat ini
      if (_mapController != null && _currentPosition != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 15),
        );
      }

      // Dapatkan alamat untuk posisi saat ini
      await getAddressFromLatLng(_selectedPosition);
    } catch (e) {
      log("Error mendapatkan lokasi: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mendapatkan alamat dari koordinat
  Future<void> getAddressFromLatLng(LatLng position) async {
    _isAddressLoading = true;
    _address = "Mencari alamat...";
    notifyListeners();

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        final components = <String>[];

        // Nama jalan
        if ((place.street ?? '').isNotEmpty) components.add(place.street!);

        // Kecamatan
        if ((place.subLocality ?? '').isNotEmpty) {
          components.add(place.subLocality!);
          _subLocality = place.subLocality!; // Simpan kecamatan
        } else if ((place.locality ?? '').isNotEmpty) {
          _subLocality = place.locality!;
          log(
            "SubLocality kosong, menggunakan Locality sebagai gantinya: ${place.locality}",
          );
        } else if ((place.subAdministrativeArea ?? '').isNotEmpty) {
          _subLocality = place.subAdministrativeArea!;
          log(
            "Menggunakan SubAdministrativeArea sebagai SubLocality: ${place.subAdministrativeArea}",
          );
        } else {
          _subLocality = "Tidak diketahui";
          log(
            "Tidak ada data wilayah yang tersedia, menggunakan 'Tidak diketahui'",
          );
        }

        // Kota
        if ((place.locality ?? '').isNotEmpty) components.add(place.locality!);

        // Kabupaten
        if ((place.subAdministrativeArea ?? '').isNotEmpty) {
          components.add(place.subAdministrativeArea!);
        }

        // Provinsi
        if ((place.administrativeArea ?? '').isNotEmpty) {
          components.add(place.administrativeArea!);
        }

        // Kode pos
        if ((place.postalCode ?? '').isNotEmpty) {
          components.add(place.postalCode!);
        }

        // Negara
        if ((place.country ?? '').isNotEmpty) components.add(place.country!);

        if (components.isEmpty) {
          _address = "Alamat tidak lengkap untuk lokasi ini";
        } else {
          _address = components.join(', ');
        }

        log("Alamat lengkap: $_address");
        log("SubLocality yang disimpan: $_subLocality");

        _isAddressLoading = false;
        notifyListeners();
      } else {
        _address = "Alamat tidak ditemukan";
        _subLocality = "Tidak diketahui";
        log(
          "Tidak ada placemark yang ditemukan, subLocality diatur ke 'Tidak diketahui'",
        );
        _isAddressLoading = false;
        notifyListeners();
      }
    } catch (e) {
      log("Error mendapatkan alamat: $e");
      _address = "Tidak dapat menemukan alamat untuk lokasi ini";
      _subLocality = "Tidak diketahui";
      _isAddressLoading = false;
      notifyListeners();
    }
  }

  // Set kamera bergerak
  void setCameraMoving(bool isMoving) {
    _isCameraMoving = isMoving;
    notifyListeners();
  }

  // Set posisi yang dipilih
  void setSelectedPosition(LatLng position) {
    _selectedPosition = position;
    notifyListeners();
  }

  // Pindah kamera ke posisi saat ini
  Future<void> moveToCurrentPosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        if (_currentPosition == null) {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          _currentPosition = LatLng(position.latitude, position.longitude);
        }

        if (_mapController != null && _currentPosition != null) {
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentPosition!, 15),
          );
        }
      }
      notifyListeners();
    } catch (e) {
      log("Error moving to current position: $e");
    }
  }

  // Pindah kamera ke posisi tertentu
  void moveToPosition(LatLng position) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    }
  }

  // Reset state variables ke nilai default
  void resetState() {
    _currentPosition = null;
    _selectedPosition = const LatLng(-7.7956, 110.3695);
    _address = "Mencari alamat...";
    _isLoading = true;
    _isAddressLoading = false;
    _isCameraMoving = false;
    _subLocality = '';
    notifyListeners();
  }

  // Hapus controller
  void disposeController() {
    // Hanya dispose controller jika tidak null
    if (_mapController != null) {
      _mapController!.dispose();
      _mapController = null;
    }
  }

  // Simpan alamat ke shared preferences
  // Simpan data alamat ke shared preferences
  Future<void> saveAddressToSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Bersihkan data lama terlebih dahulu
      await prefs.remove('selectedAddress');
      await prefs.remove('selectedLatitude');
      await prefs.remove('selectedLongitude');
      await prefs.remove('selectedSubLocality');

      // Simpan data baru
      await prefs.setString('selectedAddress', _address);
      await prefs.setDouble('selectedLatitude', _selectedPosition.latitude);
      await prefs.setDouble('selectedLongitude', _selectedPosition.longitude);
      await prefs.setString('selectedSubLocality', _subLocality);

      // Verifikasi data tersimpan dengan benar
      String? savedAddress = prefs.getString('selectedAddress');
      String? savedSubLocality = prefs.getString('selectedSubLocality');

      log("Data alamat tersimpan: $savedAddress");
      log("Data sublocality tersimpan: $savedSubLocality");

      notifyListeners();
    } catch (e) {
      log("Error menyimpan alamat ke SharedPreferences: $e");
    }
  }

  // Ambil data alamat dari shared preferences untuk sinkronisasi
  Future<Map<String, dynamic>> getAddressFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? address = prefs.getString('selectedAddress');
      double? latitude = prefs.getDouble('selectedLatitude');
      double? longitude = prefs.getDouble('selectedLongitude');
      String? subLocality = prefs.getString('selectedSubLocality');

      log("Membaca alamat dari SharedPreferences: $address");
      log("Membaca sublocality dari SharedPreferences: $subLocality");

      return {
        'address': address ?? '',
        'latitude': latitude ?? -7.7956,
        'longitude': longitude ?? 110.3695,
        'subLocality': subLocality ?? '',
      };
    } catch (e) {
      log("Error membaca alamat dari SharedPreferences: $e");
      return {
        'address': '',
        'latitude': -7.7956,
        'longitude': 110.3695,
        'subLocality': '',
      };
    }
  }

  // Membersihkan dan menyiapkan controller untuk penggunaan ulang
  void prepareForReuse() {
    // Tambahkan flag untuk menghindari notifyListeners() yang tidak perlu
    bool changed = false;

    // Membersihkan controller map dengan aman
    if (_mapController != null) {
      try {
        _mapController!.dispose();
      } catch (e) {
        log("Error saat membersihkan controller map: $e");
      }
      _mapController = null;
      changed = true;
    }

    // Jangan reset state lain karena bisa hilang data lokasi yang sudah dipilih
    // Cukup tandai bahwa tidak lagi dalam keadaan loading jika sebelumnya loading
    if (_isLoading) {
      _isLoading = false;
      changed = true;
    }

    if (_isAddressLoading) {
      _isAddressLoading = false;
      changed = true;
    }

    if (_isCameraMoving) {
      _isCameraMoving = false;
      changed = true;
    }

    // Hanya panggil notifyListeners jika ada perubahan state
    if (changed) {
      notifyListeners();
    }
  }
}
