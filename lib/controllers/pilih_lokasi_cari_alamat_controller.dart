import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:flutter_google_maps_webservices/places.dart' as places;

class PilihLokasiCariAlamatController extends ChangeNotifier {
  // API Key Google Maps
  final String googleApiKey = "AIzaSyAOoPwuh3z8gKEJczCDzouz8Bg4ukTG-W4";
  late final places.GoogleMapsPlaces _placesApi;

  // State untuk menampilkan hasil pencarian
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  // Getters
  List<Map<String, dynamic>> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  // Controller untuk input pencarian
  final TextEditingController searchController = TextEditingController();

  PilihLokasiCariAlamatController() {
    _placesApi = places.GoogleMapsPlaces(apiKey: googleApiKey);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Reset hasil pencarian
  void clearSearchResults() {
    searchController.clear();
    _searchResults = [];
    notifyListeners();
  }

  // Fungsi untuk pencarian alamat berdasarkan teks menggunakan Google Places API
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      // Gunakan Places API untuk mencari lokasi
      final response = await _placesApi.searchByText(query);
      log("Searching places with query: $query");

      // Periksa status respons
      if (response.isOkay) {
        // Mengambil hingga 10 hasil untuk ditampilkan
        List<Map<String, dynamic>> results = [];

        if (response.results.isNotEmpty) {
          // Ambil detail untuk setiap tempat yang ditemukan
          for (var i = 0; i < response.results.length && i < 10; i++) {
            final place = response.results[i];

            // Dapatkan detail alamat
            String fullAddress = place.formattedAddress ?? '';

            // Pastikan ada posisi yang valid
            if (place.geometry?.location != null) {
              results.add({
                'address': fullAddress,
                'position': LatLng(
                  place.geometry!.location.lat,
                  place.geometry!.location.lng,
                ),
                'name': place.name,
              });
            }
          }
        }

        _searchResults = results;
        _isSearching = false;
        notifyListeners();
      } else {
        log("Places API search failed, using geocoding as fallback");
        // Jika Places API gagal, gunakan geocoding sebagai fallback
        await _searchWithGeocoding(query);
      }
    } catch (e) {
      log("Error pencarian dengan Places API: $e");
      // Gunakan geocoding sebagai fallback jika Places API error
      await _searchWithGeocoding(query);
    }
  }

  // Fungsi pencarian menggunakan geocoding sebagai fallback
  Future<void> _searchWithGeocoding(String query) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(
        query,
      );

      List<Map<String, dynamic>> results = [];

      if (locations.isNotEmpty) {
        for (var i = 0; i < locations.length && i < 10; i++) {
          geocoding.Location location = locations[i];

          List<geocoding.Placemark> placemarks = await geocoding
              .placemarkFromCoordinates(location.latitude, location.longitude);

          if (placemarks.isNotEmpty) {
            geocoding.Placemark place = placemarks[0];
            final components = <String>[];

            if ((place.name ?? '').isNotEmpty) components.add(place.name!);
            if ((place.street ?? '').isNotEmpty) components.add(place.street!);
            if ((place.subLocality ?? '').isNotEmpty) {
              components.add(place.subLocality!);
            }
            if ((place.locality ?? '').isNotEmpty) {
              components.add(place.locality!);
            }
            if ((place.subAdministrativeArea ?? '').isNotEmpty) {
              components.add(place.subAdministrativeArea!);
            }
            if ((place.administrativeArea ?? '').isNotEmpty) {
              components.add(place.administrativeArea!);
            }
            if ((place.postalCode ?? '').isNotEmpty) {
              components.add(place.postalCode!);
            }
            if ((place.country ?? '').isNotEmpty) {
              components.add(place.country!);
            }

            String fullAddress = components.join(', ');

            results.add({
              'address': fullAddress,
              'position': LatLng(location.latitude, location.longitude),
              'name': place.name ?? (place.street ?? 'Lokasi'),
            });
          }
        }
      }

      _searchResults = results;
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      log("Error pencarian dengan geocoding: $e");
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
    }
  }

  // Fungsi untuk memulai pencarian dengan penundaan untuk mengurangi API calls
  void startSearch(String value) {
    if (value.length > 2) {
      // Delay pencarian untuk mengurangi panggilan API berlebihan
      Future.delayed(const Duration(milliseconds: 500), () {
        if (value == searchController.text) {
          // Pencarian hanya jika teks tidak berubah dalam 500ms
          searchPlaces(value);
        }
      });
    } else if (value.isEmpty) {
      _searchResults = [];
      notifyListeners();
    }
  }
}
